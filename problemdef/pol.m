function [parent_pop] = pol(parent_pop)
%   This procedure implements Poloni's function.
%   The canonical Poloni's function is defined as below --
%
%   f1(x) = [1 + (A1 - B1(x_1,x_2))^2 + (A2 - B2(x_1,x_2))^2]
%   f2(x) = (x_1 + 3)^2 + (x_2 + 1)^2
%   where
%       A1 = 0.5sin(1) - 2cos(1) + sin(2) - 1.5cos(2)
%       A2 = 1.5sin(1) - cos(1) + 2sin(2) - 0.5cos(2)
%       B1(x) = 0.5sin(x_1) - 2cos(x_1) + sin(x_2) - 1.5cos(x_2)
%       B2(x) = 1.5sin(x_1) - cos(x_1) + 2sin(x_2) - 0.5cos(x_2)
%   where
%       -3.15 <= x_i <= 3.15 (i = 1, 2)

global nreal ;

x = parent_pop(:,1:nreal);
a1 = (0.5 * sin(1.0)) - (2.0 * cos(1.0)) + sin(2.0) - (1.5 * cos(2.0)) ;
a2 = (1.5 * sin(1.0)) - cos(1.0) + (2.0 * sin(2.0)) - (0.5 * cos(2.0)) ;
b1 = (0.5 .* sin(x(:,1))) - (2.0 .* cos(x(:,1))) + ...
                    sin(x(:,2)) - (1.5 .* cos(x(:,2)));
b2 = (1.5 .* sin(x(:,1))) - cos(x(:,1)) + ...
                    (2.0 .* sin(x(:,2))) - (0.5 .* cos(x(:,2)));
                
f1 = 1.0 + ((a1 - b1) .^ 2.0) + ((a2 - b2) .^ 2.0) ;
f2 = ((x(:,1) + 3.0) .^ 2.0) + ((x(:,2) + 1.0) .^ 2.0) ;

parent_pop(:, (nreal+1)) = f1;
parent_pop(:, (nreal+2)) = f2;
end