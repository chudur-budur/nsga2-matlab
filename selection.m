function [ new_pop ] = selection(old_pop, new_pop)
%   Applies tournament selection to generate a child population
%   We did not vectorize this function as we want to keep this procedure
%   separate from those of the crossover and the mutation. Otherwise
%   implementation of different kind of selection strategy will not be
%   straight forward.

global nreal ;
global min_realvar ;
global max_realvar ;
global pcross_real ;
global eta_c ;

[popsize,~] = size(old_pop);

old_pop =  old_pop(randperm(end),:);
% old_pop =  shuffle(old_pop); % SLOW !!!
for i = 1:4:popsize    
    p1i = tournament(old_pop,i,  i+1);
    p2i = tournament(old_pop,i+2,i+3);
    [c1, c2] = real_cross(old_pop(p1i,1:nreal), old_pop(p2i,1:nreal), ...
                            pcross_real, eta_c, min_realvar, max_realvar);
    new_pop(i,  1:nreal) = c1 ;
    new_pop(i+1,1:nreal) = c2 ;
    p1i = tournament(old_pop,i,  i+1);
    p2i = tournament(old_pop,i+2,i+3);
    [c1, c2] = real_cross(old_pop(p1i,1:nreal), old_pop(p2i,1:nreal), ...
                            pcross_real, eta_c, min_realvar, max_realvar);
    new_pop(i+2,1:nreal) = c1 ;
    new_pop(i+3,1:nreal) = c2 ;    
end
end

function [shuffled_pop] = shuffle(pop)
%   This function uses the legacy rng for shuffling,
%   but too slow.
    [popsize,cols] = size(pop);
    shuffled_pop = zeros(popsize,cols);
    for i = 1:popsize
        shuffled_pop(i,:) = pop(rnd(1,popsize),:);
    end
end