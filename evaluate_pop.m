function [ parent_pop ] = evaluate_pop( parent_pop, obj_func )
%   This function evaluates a whole population with the supplied
%   objective function handle obj_func.

global nreal ;
global nobj ;
global ncon ;

obj_col = nreal + 1: nreal + nobj ;
parent_pop(:,obj_col) = 0 ;
parent_pop = obj_func(parent_pop);

if(ncon > 0)
    cv_col = nreal + nobj + ncon + 1 ;
    parent_pop(:,cv_col) = 0;  
    cons = parent_pop(:,nreal+nobj+1:nreal+nobj+ncon);    
    % parent_pop(:,cv_col) = sum(((cons < 0.0) .* cons),2);
    parent_pop(:,cv_col) = sum(bsxfun(@times, ...
                                    bsxfun(@lt, cons, 0.0), cons),2);
end
end
