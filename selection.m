function [ new_pop ] = selection(old_pop, new_pop)
%SELECTION  Makes a child population by tournament selection and crossover.
%
%   new_pop = selection(old_pop, new_pop) shuffles old_pop, then walks
%   through it four individuals at a time. Each group of four runs two
%   binary tournaments (rows i vs i+1 and i+2 vs i+3), and the two
%   winners are crossed over to make two children. This is done twice
%   per group, so every group gives four children, and new_pop ends up
%   with as many rows as old_pop.
%
%   Only the variable columns of new_pop are written, the rest are
%   filled later by evaluate_pop() and the ranking functions.
%
%   Inputs:
%       old_pop = parent population, must already be ranked
%       new_pop = preallocated child population, same size as old_pop
%   Output:
%       new_pop = child population with the new variables
%
%   Crossover is real_cross() (SBX) for real variables, or
%   bin_cross_two_point() for binary variables.
%
%   Note: popsize must be a multiple of 4.
%
%   We did not vectorize this function as we want to keep this procedure
%   separate from those of the crossover and the mutation. Otherwise
%   implementation of different kind of selection strategy will not be
%   straight forward.
%
%   Globals used:
%       nreal, nbin, nbits, pcross_bin, min_realvar, max_realvar,
%       pcross_real, eta_c

global nreal ;
global nbin ;
global nbits ;
global min_binvar ;
global max_binvar ;
global pcross_bin ;
global min_realvar ;
global max_realvar ;
global pcross_real ;
global eta_c ;

[popsize,~] = size(old_pop);

% shuffle the parents so the tournament pairs are random
old_pop =  old_pop(randperm(end),:);
% old_pop =  shuffle(old_pop); % SLOW !!!
for i = 1:4:popsize
    % first pair of children
    p1i = tournament(old_pop,i,  i+1);
    p2i = tournament(old_pop,i+2,i+3);
    if(nreal > 0)
        [c1, c2] = real_cross(old_pop(p1i,1:nreal), ...
                                old_pop(p2i,1:nreal), ...
                                pcross_real, eta_c, ...
                                min_realvar, max_realvar);
    elseif(nbin > 0)
        [c1, c2] = bin_cross_two_point(old_pop(p1i, 1:sum(nbits)), ...
                                old_pop(p2i, 1:sum(nbits)), ...
                                nbits, pcross_bin);
    end
    new_pop(i,  1:nreal) = c1 ;
    new_pop(i+1,1:nreal) = c2 ;
    % second pair of children, same four parents but new tournaments
    p1i = tournament(old_pop,i,  i+1);
    p2i = tournament(old_pop,i+2,i+3);
    if(nreal > 0)
            [c1, c2] = real_cross(old_pop(p1i,1:nreal), ...
                                    old_pop(p2i,1:nreal), ...
                                    pcross_real, eta_c, ...
                                    min_realvar, max_realvar);
    elseif(nbin > 0)
            [c1, c2] = bin_cross_two_point(old_pop(p1i,1:sum(nbits)), ...
                                    old_pop(p2i,1:sum(nbits)), ...
                                    pcross_bin);
    end
    new_pop(i+2,1:nreal) = c1 ;
    new_pop(i+3,1:nreal) = c2 ;    
end
end

function [shuffled_pop] = shuffle(pop)
%   This function uses the legacy rng for shuffling,
%   but too slow. Not used anymore, the legacy rng (rnd) is removed,
%   kept only for reference.
    [popsize,cols] = size(pop);
    shuffled_pop = zeros(popsize,cols);
    for i = 1:popsize
        shuffled_pop(i,:) = pop(rnd(1,popsize),:);
    end
end