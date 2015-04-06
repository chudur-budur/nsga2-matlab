function [parent_pop] = sch2(parent_pop)
%   This procedure implements sch2 (Schaffer's) function.
%   The canonical sch2 function is defined as below --
%
%   f_1 = -x_1      if x <= 1
%       = x_1 - 2   if 1 < x <= 3
%       = 4 - x_1   if 3 < x <= 4
%       = x_1 - 4   if x > 4
%   f_2 = (x_1 - 5)^2
%   where
%       -5.0 <= x_1 <= 10.0

global nreal ;

x = parent_pop(:,1:nreal);
f1 = ((x(:,1) <= 1.0) .* (x(:,1) .* -1.0)) ...
        + (((x(:,1) > 1) & (x(:,1) <= 3)) .* (x(:,1) - 2.0)) ...
        + (((x(:,1) > 3) & (x(:,1) <= 4)) .* (4.0 - x(:,1))) ...
        + ((x(:,1) > 4) .* (x(:,1) - 4.0));
f2 = (x(:,1) - 5.0) .^ 2.0 ;

parent_pop(:, (nreal+1)) = f1 ;
parent_pop(:, (nreal+2)) = f2 ;
end

