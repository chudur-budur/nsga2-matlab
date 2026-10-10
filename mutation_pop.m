function [pop] = mutation_pop(pop)
%MUTATION_POP  Applies mutation to whole population.
%
%   pop = mutation_pop(pop) runs real_mutate() (polynomial mutation)
%   on the variables of every individual, one row at a time. Only the
%   real variable columns are touched.
%
%   Note: there is no binary mutation yet, so this only works for
%   real-coded problems.
%
%   Globals used:
%       pmut_real, eta_m, min_realvar, max_realvar
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

