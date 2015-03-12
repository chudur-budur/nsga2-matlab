function [ new_pop ] = selection(old_pop,new_pop)
%   Applies tournament selection to generate a child population

global popsize ;
global nreal ;

old_pop =  old_pop(randperm(end),:);

for i = 1:4:popsize    
    p1i = tournament(old_pop,i,  i+1);
    p2i = tournament(old_pop,i+2,i+3);
    [c1, c2] = real_cross(old_pop(p1i,1:nreal), old_pop(p2i,1:nreal));
    new_pop(i,  1:nreal) = c1 ;
    new_pop(i+1,1:nreal) = c2 ;
    p1i = tournament(old_pop,i,  i+1);
    p2i = tournament(old_pop,i+2,i+3);
    [c1, c2] = real_cross(old_pop(p1i,1:nreal), old_pop(p2i,1:nreal));
    new_pop(i+2,1:nreal) = c1 ;
    new_pop(i+3,1:nreal) = c2 ;    
end
end

