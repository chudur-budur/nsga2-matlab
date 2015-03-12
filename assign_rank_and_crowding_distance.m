function [ranked_pop] = assign_rank_and_crowding_distance(pop)
%   This procedure applies the non-dominated sort and
%   then compute the crowding distance within each front.

global popsize ;
global nreal ;
global nobj ;
global ncon ;
rank_col = nreal + nobj + ncon + 2 ;

all_indices = 1:popsize; % initially start with the whole population
% generate the dominance matrix with the current indices
dom_mat = generate_dominance_matrix(... % SLOW !!! Need to optimize
                pop(all_indices,:), ...
                all_indices);
front = 1 ; % initial front is 1
while (not(isempty(all_indices)))
% for i = 1:1
    % get the indices of the current pf
    minus_one_count = horzcat(all_indices', sum(dom_mat == -1,2)) ;
    pf_indices = minus_one_count(minus_one_count(:,2) == 0,1);
    % assign the current front number
    pop(pf_indices, rank_col) = front;
    % now do the crowding distance assignment for this front
    pop = assign_crowding_distance(pop, pf_indices);   
    % now drop the ranked column/row from the dominance matrix
    dom_mat = drop_ranked_indices(dom_mat, pf_indices);    
    % remove the ranked indices from the list
    % all_indices = setdiff(all_indices, pf_indices); % SLOW!!!
    flag = ismember(all_indices, pf_indices);
    all_indices = all_indices(~flag);    
    % go to next front
    front = front + 1;
end
ranked_pop = sortrows(pop, rank_col) ;
end

function [mat] = drop_ranked_indices(mat, indices)
    % find(any(bsxfun(@eq,mat(:,1),indices),2)); % BETTER ??
    rel_col_indices = find(ismember(mat(:,1),indices));  
    mat(:,rel_col_indices+1) = [] ;
    mat(rel_col_indices,:) = [] ;    
end

function [dom_mat] = generate_dominance_matrix(pop, indices)
%   Generate the dominance matrix from the given population.
%   This function is O(n^2), OPTIMIZATION NEEDED !!
%
%     |   *c    *d
%     |
%     |   *a    *b
%    _|_______________
%     |
%   
%   For the above objective values, the dominance matrix 
%   will look like this --
%   
%       A   B   C   D
%   A   0   0   1   1
%   B   0   0   0   1
%   C  -1   0   0   0
%   D  -1  -1   0   0
%
%   First optimization: fill only the upper triangular and paste the 
%                       mirror image to the lower triangular, and the
%                       values are reversed.

global nreal ;
global nobj ;
global ncon ;

obj_col = nreal+1:nreal+nobj;
cv_col = nreal+nobj+ncon+1;
[popsize,~] = size(pop);
mat = zeros(popsize,popsize);
% now fill only the upper triangular of mat
for row = 1:popsize
    for col = row + 1:popsize
        if(row ~= col) 
            obj_vec1 = pop(row,obj_col);
            cv_vec1 = pop(row,cv_col);
            obj_vec2 = pop(col,obj_col);
            cv_vec2 = pop(col,cv_col);
            mat(row, col) = ...
                check_dominance(obj_vec1, cv_vec1, obj_vec2, cv_vec2);
        end
    end
end
% now get mirror image of mat, and flip it over the lower triangular and
% in the mean time revert all +1 to -1 and vise-versa.
mat = bsxfun(@minus, zeros(size(mat)), triu(mat,1)') + triu(mat,1) ;
% now add the first column as the original indices of the population
dom_mat = zeros(popsize, popsize+1);
dom_mat(:,1) = indices' ;
dom_mat(:,2:end) = mat ;
end