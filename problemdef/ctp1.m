function [parent_pop] = ctp1(parent_pop)
%CTP1  CTP1 test problem, 2 objectives, 2 constraints.
%
%   parent_pop = ctp1(parent_pop) evaluates every row of
%   parent_pop at once.
%
%   This procedure implements the CTP1 function of Deb, Pratap and
%   Meyarivan (2001), ported from test_problem() for ctp1 in nsga2-c.
%   The canonical CTP1 function is defined as below --
%   f_1 = x_1
%   f_2 = g * exp(-f_1 / g)
%   g(x_2) = 1.0 + x_2
%   s.t.
%       c_1(x) = f_2 / (0.858 * exp(-0.541 * f_1)) - 1.0 >= 0
%       c_2(x) = f_2 / (0.728 * exp(-0.295 * f_1)) - 1.0 >= 0
%   i.e. f_2 >= a_j * exp(-b_j * f_1), in the normalized form of the
%   c-code.
%
%   The objectives are written into columns nreal+1 : nreal+nobj.
%   The constraints are written into columns
%   nreal+nobj+1 : nreal+nobj+ncon, normalized so that a value
%   >= 0 means the constraint is satisfied.
%
%   Use it with input_data/ctp1.in.

global nreal ;
global ncon ;
global nobj ;

cindex = nreal + nobj + 1 : nreal + nobj + ncon ;

x = parent_pop(:,1:nreal);
g = 1.0 + x(:,2);
f1 = x(:,1);
f2 = g .* exp(-f1 ./ g);

c = zeros(size(x,1), 2);
c(:,1) = f2 ./ (0.858 .* exp(-0.541 .* f1)) - 1.0;
c(:,2) = f2 ./ (0.728 .* exp(-0.295 .* f1)) - 1.0;

parent_pop(:, (nreal+1)) = f1 ;
parent_pop(:, (nreal+2)) = f2 ;
parent_pop(:, cindex) = c ;
end
