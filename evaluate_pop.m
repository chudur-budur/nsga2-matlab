function [ parent_pop ] = evaluate_pop( parent_pop, obj_func )
%   This function evaluates a whole population with the supplied
%   objective function handle obj_func.

parent_pop = obj_func(parent_pop);
end
