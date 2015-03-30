function [mixed_pop] = merge_pop(old_pop, new_pop)
%   Merges two pops.

mixed_pop = vertcat(old_pop, new_pop);

end

