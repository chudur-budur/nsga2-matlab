function [pop] = mutation_pop(pop)
%MUTATION_POP  Applies mutation to whole population.
%
%   pop = mutation_pop(pop) mutates the variables of every individual,
%   one row at a time. Real variables get real_mutate() (polynomial
%   mutation), binary variables get bin_mutate() (bit-flip mutation).
%   Only the variable columns are touched.
%
%   Globals used:
%       nreal, nbin, sumnbits, pmut_real, eta_m, min_realvar,
%       max_realvar, pmut_bin
global nreal ;
global nbin ;
global sumnbits ;
global pmut_real ;
global eta_m ;
global min_realvar ;
global max_realvar ;
global pmut_bin ;

[popsize,~] = size(pop);

if(nreal > 0)
    for i = 1:popsize
        pop(i,1:nreal) = real_mutate(pop(i,1:nreal), pmut_real, eta_m, ...
                                        min_realvar, max_realvar);
    end
elseif(nbin > 0)
    for i = 1:popsize
        pop(i,1:sumnbits) = bin_mutate(pop(i,1:sumnbits), pmut_bin);
    end
end

end

