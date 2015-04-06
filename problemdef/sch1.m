function [parent_pop] = sch1(parent_pop)
%   This procedure implements sch1 (Schaffer's) function.
%   The canonical sch1 function is defined as below --
%
%   f_1 = x_1^2
%   f_2 = (x_1 - 2)^2
%   where
%       -10.0 <= x_1 <= 10.0

global nreal ;

x = parent_pop(:,1:nreal);
f1 = x(:,1) .^ 2.0 ;
f2 = (x(:,1) - 2.0) .^ 2.0 ;


parent_pop(:, (nreal+1)) = f1 ;
parent_pop(:, (nreal+2)) = f2 ;
end

