function [parent_pop] = ctp7(parent_pop)
%CTP7  CTP7 test problem, 2 objectives, 1 constraint.
%
%   parent_pop = ctp7(parent_pop) evaluates every row of
%   parent_pop at once.
%
%   This procedure implements the CTP7 function of Deb, Pratap and
%   Meyarivan (2001), ported from test_problem() for ctp7 in nsga2-c.
%   The canonical CTP7 function is defined as below --
%   f_1 = x_1
%   f_2 = g * (1.0 - sqrt(f_1 / g))
%   g(x_2) = 1.0 + x_2
%   s.t.
%       c(x) = cos(theta) * (f_2 - e) - sin(theta) * f_1
%              >= a * |sin(b * pi * (sin(theta) * (f_2 - e)
%                                   + cos(theta) * f_1) ^ c)| ^ d
%   written here, like the c-code, in the normalized form
%       c(x) = lhs / rhs - 1.0 >= 0
%   with theta = -0.05 * pi, a = 40.0, b = 5.0, c = 1.0, d = 6.0, e = 0.0
%
%   The objectives are written into columns nreal+1 : nreal+nobj.
%   The constraints are written into columns
%   nreal+nobj+1 : nreal+nobj+ncon, normalized so that a value
%   >= 0 means the constraint is satisfied.
%
%   Use it with input_data/ctp7.in.

global nreal ;
global ncon ;
global nobj ;

cindex = nreal + nobj + 1 : nreal + nobj + ncon ;

x = parent_pop(:,1:nreal);
g = 1.0 + x(:,2);
f1 = x(:,1);
f2 = g .* (1.0 - sqrt(f1 ./ g));

c = ctp_constraint(f1, f2, -0.05 * pi, 40.0, 5.0, 1.0, 6.0, 0.0);

parent_pop(:, (nreal+1)) = f1 ;
parent_pop(:, (nreal+2)) = f2 ;
parent_pop(:, cindex) = c ;
end

function [val] = ctp_constraint(f1, f2, theta, a, b, c, d, e)
%   val = exp1 / exp2 - 1.0, where
%   exp1 = cos(theta) * (f_2 - e) - sin(theta) * f_1
%   exp2 = a * |sin(b * pi * (sin(theta) * (f_2 - e)
%                               + cos(theta) * f_1) ^ c)| ^ d
exp1 = (f2 - e) .* cos(theta) - f1 .* sin(theta);
exp2 = (f2 - e) .* sin(theta) + f1 .* cos(theta);
exp2 = b .* pi .* (exp2 .^ c);
exp2 = abs(sin(exp2));
exp2 = a .* (exp2 .^ d);
val = exp1 ./ exp2 - 1.0;
end
