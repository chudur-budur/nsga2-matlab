function [ parent_pop ] = evaluate_pop( parent_pop, obj_func )
%EVALUATE_POP  Evaluates the objectives and constraints of a population.
%
%   parent_pop = evaluate_pop(parent_pop, obj_func) calls obj_func (one
%   of the functions in ./problemdef) on the whole population at once.
%   obj_func fills in the objective and constraint columns, then this
%   function computes the total constraint violation (cv) column.
%
%   cv is the sum of the violated constraint values, so it is <= 0 and
%   it is 0 for a feasible individual. A constraint value >= 0 means
%   that constraint is satisfied.
%
%   Inputs:
%       parent_pop = population matrix, see initialize_pop()
%       obj_func   = function handle, e.g. @zdt1
%   Output:
%       parent_pop = the same population with objs, cons and cv filled
%
%   Globals used:
%       nreal, nobj, ncon

global nreal ;
global nobj ;
global ncon ;

% clear the old objective values before evaluation
obj_col = nreal + 1: nreal + nobj ;
parent_pop(:,obj_col) = 0 ;
parent_pop = obj_func(parent_pop);

% sum up only the negative (violated) constraint values
if(ncon > 0)
    cv_col = nreal + nobj + ncon + 1 ;
    parent_pop(:,cv_col) = 0;  
    cons = parent_pop(:,nreal+nobj+1:nreal+nobj+ncon);    
    % parent_pop(:,cv_col) = sum(((cons < 0.0) .* cons),2);
    parent_pop(:,cv_col) = sum(bsxfun(@times, ...
                                    bsxfun(@lt, cons, 0.0), cons),2);
end
end
