function [parent_pop] = fon(parent_pop)
%FON  Fonseca and Fleming's test problem, 2 objectives.
%
%   parent_pop = fon(parent_pop) evaluates every row of
%   parent_pop at once.
%
%   This procedure implements Fonseca's function.
%   The canonical Fonseca's function is defined as below --
%
%   f_1 = 1 - exp(-1.0 * (sum_{i = 1}^n [(x_i - 1/sqrt(n))^2)])
%   f_2 = 1 - exp(-1.0 * (sum_{i = 1}^n [(x_i + 1/sqrt(n))^2)])
%   -4.0 <= x_i <= 4.0 (i = 1, 2, 3, ..., 5)
%
%   The objectives are written into columns nreal+1 : nreal+nobj.
%
%   Use it with input_data/fon.in.

global nreal ;

x = parent_pop(:,1:nreal);

f1 = 1.0 - exp(-1.0 .* sum(((x - (1.0/sqrt(nreal))) .^ 2.0), 2));
f2 = 1.0 - exp(-1.0 .* sum(((x + (1.0/sqrt(nreal))) .^ 2.0), 2));

parent_pop(:, (nreal+1)) = f1;
parent_pop(:, (nreal+2)) = f2;
end