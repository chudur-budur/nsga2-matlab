function [parent_pop] = kur(parent_pop)
%   This procedure implements Kursawe's function.
%   The canonical Kursawe's function is defined as below --
%
%   f_1 = sum_{i = 1}^2 [-10.0 * exp(-0.2 * sqrt(x_i^2 + x_{i+1}^2)]
%   f_2 = sum_{i = 1}^3 [|x_i|^0.8 + 5.0 * sin(x_i^3)]
%   where
%       -5.0 <= x_i <= 5.0 (i = 1, 2, 3)

global nreal ;

x = parent_pop(:,1:nreal);
f1 = sum(-10.0 .* exp(-0.2 .* sqrt(bsxfun(...
                @plus, (x(:,1:(end-1)) .^ 2), (x(:,2:end) .^ 2)))),2);
f2 = sum((abs(x) .^ 0.8) + (5.0 .* sin(x .^ 3.0)), 2);

parent_pop(:, (nreal+1)) = f1;
parent_pop(:, (nreal+2)) = f2;
end