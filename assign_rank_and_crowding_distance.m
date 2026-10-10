function [pop] = assign_rank_and_crowding_distance(pop)
%ASSIGN_RANK_AND_CROWDING_DISTANCE  Non-dominated sort plus crowding.
%
%   pop = assign_rank_and_crowding_distance(pop) applies the
%   non-dominated sort and then compute the crowding distance within
%   each front. Used once on the first generation in nsga2.m, after
%   that fill_nondominated_sort() does the job.
%
%   The fronts are peeled off one by one: the current front is every
%   remaining individual that is not dominated by any other remaining
%   individual (no -1 in its row of the dominance matrix). Those get
%   the current front number as rank, then they are removed and the
%   loop goes on until everyone is ranked.
%
%   Unlike assign_rank_only(), the rows are not sorted by rank.
%
%   Input/Output:
%       pop = population matrix, the rank and crowd-dist columns are
%             filled in
%
%   Globals used:
%       nreal, nbin, nbits, nobj, ncon

global nreal ;
global nbin ;
global nbits ;
global nobj ;
global ncon ;

if(nreal > 0)
    rank_col = nreal + nobj + ncon + 2 ;
elseif(nbin > 0)
    rank_col = sum(nbits) + nobj + ncon + 2 ;
end

[popsize, ~] = size(pop);

all_indices = 1:popsize; % initially start with the whole population
% generate the dominance matrix with the current indices
dominance_matrix = generate_dominance_matrix(... % It's fast now
                pop(all_indices,:), ...
                all_indices);

front = 1 ; % initial front is 1
while (not(isempty(all_indices)))
% for i = 1:1
    % now reduce the dom_mat    
    dom_mat = [all_indices.', dominance_matrix(all_indices, all_indices+1)];    
    % get the indices of the current pf
    minus_one_count = [all_indices.', sum(dom_mat == -1,2)] ;    
    pf_indices = minus_one_count(minus_one_count(:,2) == 0,1);
    % assign the current front number
    pop(pf_indices, rank_col) = front;
    % now do the crowding distance assignment for this front
    pop = assign_crowding_distance(pop, pf_indices);   
    % remove the ranked indices from the list
    all_indices = all_indices(~ismember(all_indices, pf_indices));
    % go to next front
    front = front + 1;
end
end