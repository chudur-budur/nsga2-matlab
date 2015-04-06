function [ pop ] = initialize_pop(rseed)
%   This function initializes a whole populaiton, where the populations
%   is a matrix with dimension like this --
%                   nvar    nobj    ncon    constr     rank     crowd-dist
%   indiv[1]        ...     ...     ...     ...        ...      ...
%   indiv[2]        ...     ...     ...     ...        ...      ...
%   .
%   .
%   indiv[popsize]  ...     ...     ...     ...        ...      ...

global popsize ;
global nreal ;
global nobj ;
global ncon ;
global min_realvar ;
global max_realvar ;

% init rng
rng(rseed, 'twister');

% global seed ; % Knuth's algo, SLOW !!!
% seed = rseed ;
% randomize(); % SLOW !!!

% each individual is arranged like this --
% [nvar, nobj, ncon, cv, rank, crowd-dist]
pop = zeros(popsize, nreal + nobj + ncon + 3);
rand_vals = rand(popsize, nreal);
% rand_vals = randompercv(popsize, nreal); % SLOW !!!
rand_vals = bsxfun(@plus, bsxfun(@times, rand_vals, ...
                                        max_realvar'-min_realvar'), ...
                                    min_realvar');
pop(:,1:nreal) = rand_vals;
end

