function [pop] = mutation_pop(pop)
%   Applies mutation to whole population.
global pmut_real ;
global eta_m ;
global min_realvar ;
global max_realvar ;

[popsize,~] = size(pop);
nreal = length(min_realvar);

for i = 1:popsize 
    pop(i,1:nreal) = real_mutate(pop(i,1:nreal), pmut_real, eta_m, ...
                                    min_realvar, max_realvar);
end

end

