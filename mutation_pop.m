function [pop] = mutation_pop(pop)
%   Applies mutation to whole population.

global popsize ;
global nreal ;

for i = 1:popsize 
    pop(i,1:nreal) = real_mutate(pop(i,1:nreal));
end

end

