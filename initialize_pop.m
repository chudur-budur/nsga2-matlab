function [ pop ] = initialize_pop()
%INITIALIZE_POP  Creates a random initial population.
%
%   pop = initialize_pop() returns a popsize-by-ncols matrix where the
%   population is arranged like this --
%                   nvar    nobj    ncon    constr     rank     crowd-dist
%   indiv[1]        ...     ...     ...     ...        ...      ...
%   indiv[2]        ...     ...     ...     ...        ...      ...
%   .
%   .
%   indiv[popsize]  ...     ...     ...     ...        ...      ...
%
%   Real variables are drawn uniformly from [min_realvar, max_realvar].
%   Binary variables are drawn as random bits, sumnbits in total.
%   All the other columns (objs, cons, cv, rank, crowd-dist) are set
%   to zero, they are filled later by evaluate_pop() and the ranking
%   functions.
%
%   The rng must be seeded before calling this (see nsga2.m).
%
%   Globals used:
%       popsize, nreal, nbin, nbits, nobj, ncon, min_realvar, max_realvar

global popsize ;
global nreal ;
global sumnbits ;
global nbin ;
global nobj ;
global ncon ;
global min_realvar ;
global max_realvar ;

if(nreal > 0)
    % each individual is arranged like this --
    % [nvar, nobj, ncon, cv, rank, crowd-dist]
    pop = zeros(popsize, nreal + nobj + ncon + 3);

    % scale the uniform [0,1] values into the variable bounds
    rand_vals = rand(popsize, nreal);
    rand_vals = bsxfun(@plus, bsxfun(@times, rand_vals, ...
                                            max_realvar'-min_realvar'), ...
                                        min_realvar');
    pop(:,1:nreal) = rand_vals;
    return ;
elseif(nbin > 0)
    % each individual is arranged like this --
    % [bits, nobj, ncon, cv, rank, crowd-dist]
    pop = zeros(popsize, sumnbits + nobj + ncon + 3);
    rand_vals = rand(popsize, sumnbits) > 0.5 ;
    pop(:,1:sumnbits) = rand_vals ;
end
end

