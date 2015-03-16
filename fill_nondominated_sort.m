function [ new_pop ] = fill_nondominated_sort(mixed_pop)
%   This function fills up the new_pop from the old_pop
%   according to the rank and crowding distance. This code
%   is also extremely slow, need to optimize.

global nreal ;
global nobj ;
global ncon ;

rank_col = nreal + nobj + ncon + 2 ;
cd_col = rank_col + 1;

[full_size,~] = size(mixed_pop);
half_size = full_size / 2;

% remove all rank and cd info
mixed_pop(:,rank_col) = 0 ;
mixed_pop(:,cd_col) = 0 ;

% assign rank
% pprint('[fill_nodominated_sort] mixed_pop before rank:\n', mixed_pop);
mixed_pop = assign_rank_only(mixed_pop);
% pprint('[fill_nodominated_sort] mixed_pop after rank:\n', mixed_pop);

last_rank = mixed_pop(half_size,rank_col);
next_last_rank = mixed_pop(half_size+1, rank_col);
% now assign crowding distance up to the last rank
for r = 1:last_rank
    % find the indices of the rank r
    rank_indices = find(ismember(mixed_pop(:,rank_col),r));
    % assign cd's to rank r
    mixed_pop = assign_crowding_distance(mixed_pop, rank_indices);
    % if rank r is overlapped, sort the last rank
    if (r == last_rank && last_rank == next_last_rank)
        mixed_pop(rank_indices,:) = sortrows(mixed_pop(rank_indices,:), -cd_col);
    end
end
% pprint('[fill_nondominated_sort] mixed_pop after cd:\n', mixed_pop);
new_pop = mixed_pop(1:half_size,:) ;
end