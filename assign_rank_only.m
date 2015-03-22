function [ranked_pop] = assign_rank_only(pop)
%   This function assigns only rank but no crowding distance
global nreal ;
global nobj ;
global ncon ;
rank_col = nreal + nobj + ncon + 2 ;
[popsize, ~] = size(pop);

all_indices = 1:popsize; % initially start with the whole population
% generate the dominance matrix with the current indices
dom_mat = generate_dominance_matrix(... % It's fast now
                pop(all_indices,:), ...
                all_indices);
front = 1 ; % initial front is 1
while (not(isempty(all_indices)))
% for i = 1:1
    % get the indices of the current pf
    minus_one_count = [all_indices', sum(dom_mat == -1,2)] ;
    pf_indices = minus_one_count(minus_one_count(:,2) == 0,1);
    % assign the current front number
    pop(pf_indices, rank_col) = front;
    % now drop the ranked column/row from the dominance matrix
    dom_mat = drop_ranked_indices(dom_mat, pf_indices);    
    % remove the ranked indices from the list
    all_indices = all_indices(~ismember(all_indices, pf_indices));
    % go to next front
    front = front + 1;
end
ranked_pop = sortrows(pop, rank_col) ;
end

function [mat] = drop_ranked_indices(mat, indices)
    % find(any(bsxfun(@eq, mat(:,1), indices.'),2)); % is better than 
    % find(ismember(mat(:,1),indices));  
    rel_col_indices = find(any(bsxfun(@eq, mat(:,1), indices.'),2)); 
    mat(:,rel_col_indices+1) = [] ;
    mat(rel_col_indices,:) = [] ;
end