function [mixed_pop] = merge_pop(old_pop, new_pop)
%MERGE_POP  Stacks two populations into one.
%
%   mixed_pop = merge_pop(old_pop, new_pop) puts new_pop under old_pop,
%   so the parents and the children make a 2 * popsize population for
%   fill_nondominated_sort().

mixed_pop = vertcat(old_pop, new_pop);

end

