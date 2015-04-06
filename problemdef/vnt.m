function [parent_pop] = vnt(parent_pop)
%   This procedure implements Viennet's function.
%   The canonical Viennet's function is defined as below --
%   
%   f_1 = (0.5 * (x_1 ^ 2.0 + x_2 ^ 2.0)) + sin(x_1 ^ 2.0 + x_2 ^ 2.0)
%   f_2 = ((((3.0 * x_1) - (2.0 * x_2) + 4.0)^2.0)/8.0) 
%                       + (((x_1 - x_2 + 1.0)^2.0)/27.0) + 15.0
%   f_3 = (1.0/(x_1 ^ 2.0 + x_2 ^ 2.0 + 1.0)) 
%                       - (1.1 * exp(-1.0 * ((x_1 ^ 2.0) + (x_2 ^ 2.0))))
%   where
%       -3.0 <= x_i <= 3.0  (i = 1,2)

global nreal ;

x = parent_pop(:,1:nreal);
f1 = (0.5 .* ((x(:,1) .^ 2.0) + (x(:,2) .^ 2.0))) ...
                + sin((x(:,1) .^ 2.0) + (x(:,2) .^ 2.0)) ;
f2 = ((((3.0 .* x(:,1)) - (2.0 .* x(:,2)) + 4.0) .^ 2.0) ./ 8.0) ...
            + (((x(:,1) - x(:,2) + 1.0) .^ 2.0) ./ 27.0) + 15.0 ;
f3 = (1.0 ./ (x(:,1) .^ 2.0 + x(:,2) .^ 2.0 + 1.0)) ...
            - (1.1 .* exp(-1.0 * ((x(:,1) .^ 2.0) + (x(:,2) .^ 2.0))));

parent_pop(:, (nreal+1)) = f1 ;
parent_pop(:, (nreal+2)) = f2 ;
parent_pop(:, (nreal+3)) = f3 ;
end