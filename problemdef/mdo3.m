function [parent_pop] = mdo3(parent_pop)
%MDO3  Exercise 3 of the multi-objective chapter of the MDO book.
%
%   parent_pop = mdo3(parent_pop) evaluates every row of
%   parent_pop at once.
%
%   This procedure implements the problem from exercise 3 in
%   Martins and Ning, Engineering Design Optimization, chapter 9,
%   https://mdobook.github.io/html/multiobj/
%   The function is defined as below --
%   f_1 = x_1^2 + x_2^2
%   f_2 = (x_1 - 1)^2 + 20 * (x_2 - 2)^2
%   where
%       -5.0 <= x_i <= 5.0 (i = 1, 2)
%   The book does not give any bounds, these are chosen to contain
%   the pareto set with some room around it.
%
%   The pareto set is the curve from (0,0) to (1,2) --
%       x_2 = 40 * x_1 / (1 + 19 * x_1),  0 <= x_1 <= 1
%
%   The objectives are written into columns nreal+1 : nreal+nobj.
%
%   Use it with input_data/mdo3.in.

global nreal ;

x = parent_pop(:,1:nreal);
f1 = (x(:,1) .^ 2.0) + (x(:,2) .^ 2.0);
f2 = ((x(:,1) - 1.0) .^ 2.0) + (20.0 .* ((x(:,2) - 2.0) .^ 2.0));

parent_pop(:, (nreal+1)) = f1;
parent_pop(:, (nreal+2)) = f2;
end
