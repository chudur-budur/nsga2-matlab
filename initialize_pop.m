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
global nbits ;
global nbin ;
global nobj ;
global ncon ;
global min_realvar ;
global max_realvar ;

% init rng
rng(rseed, 'twister');

% Knuth's algo, SLOW !!!
% global seed ; 
% seed = rseed ;
% randomize(); % SLOW !!!

if(nreal > 0)
    % each individual is arranged like this --
    % [nvar, nobj, ncon, cv, rank, crowd-dist]
    pop = zeros(popsize, nreal + nobj + ncon + 3);

    rand_vals = rand(popsize, nreal);
    % rand_vals = randompercv(popsize, nreal); % SLOW !!!
    rand_vals = bsxfun(@plus, bsxfun(@times, rand_vals, ...
                                            max_realvar'-min_realvar'), ...
                                        min_realvar');
    pop(:,1:nreal) = rand_vals;
    return ;
elseif(nbin > 0)
    pop = zeros(popsize, sum(nbits) + nobj + ncon + 3);
    rand_vals = rand(popsize, sum(nbits)) > 0.5 ;
    pop(:,1:sum(nbits)) = rand_vals ;
end
end

