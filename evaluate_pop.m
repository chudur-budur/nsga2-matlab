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
%       nreal, nbin, sumnbits, nobj, ncon

global nreal ;
global nbin ;
global sumnbits ;
global nobj ;
global ncon ;

% number of variable columns, real or binary
if(nreal > 0)
    nvar = nreal ;
elseif(nbin > 0)
    nvar = sumnbits ;
end

% clear the old objective values before evaluation
obj_col = nvar + 1: nvar + nobj ;
parent_pop(:,obj_col) = 0 ;
parent_pop = obj_func(parent_pop);

% sum up only the negative (violated) constraint values
if(ncon > 0)
    cv_col = nvar + nobj + ncon + 1 ;
    parent_pop(:,cv_col) = 0;  
    cons = parent_pop(:,nvar+nobj+1:nvar+nobj+ncon);    
    % parent_pop(:,cv_col) = sum(((cons < 0.0) .* cons),2);
    parent_pop(:,cv_col) = sum(bsxfun(@times, ...
                                    bsxfun(@lt, cons, 0.0), cons),2);
end
end
