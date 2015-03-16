function [ parent_pop ] = evaluate_pop( parent_pop, obj_func )
%   This function evaluates a whole population with the supplied
%   objective function handle obj_func.

global nreal ;
global nobj ;
obj_col = nreal + 1: nreal + nobj ;
parent_pop(:,obj_col) = 0 ;
parent_pop = obj_func(parent_pop);
end
