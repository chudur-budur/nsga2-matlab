function [ pop ] = initialize_pop()
%   This function initializes a whole populaiton, where the populations
%   is a matrix with dimension like this --
%                   nvar    nobj    constr     rank     crowd-dist
%   indiv[1]        ...     ...     ...        ...      ...
%   indiv[2]        ...     ...     ...        ...      ...
%   .
%   .
%   indiv[popsize]  ...     ...     ...        ...      ...

global popsize ;
global nreal ;
global nobj ;
global min_realvar ;
global max_realvar ;

% each individual is arranged like this --
% [nvar, nobj, constr, rank, crowd-dist]
pop = zeros(popsize, nreal + nobj + 3);
rand_vals = rand(popsize, nreal);
rand_vals = bsxfun(@plus, bsxfun(@times, rand_vals, ...
                                        max_realvar'-min_realvar'), ...
                                    min_realvar');
pop(:,1:nreal) = rand_vals;
end

