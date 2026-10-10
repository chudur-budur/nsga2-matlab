function [parent_pop] = zdt4(parent_pop)
%ZDT4  ZDT4 test problem, 2 objectives, many local fronts.
%
%   parent_pop = zdt4(parent_pop) evaluates every row of
%   parent_pop at once.
%
%   This procedure implements zdt4 function.
%   The canonical zdt4 function is defined as below --
%   f_1 = x_1
%   f_2 = g * h
%   g(x_2, x_3, ..., x_n) = 91.0 + sum_{i = 2}^n x_i^2 - 10 * cos(4 * pi * x_i)
%   h(f_1,g) = 1.0 - sqrt(f_1/g)
%   0 <= x_1 <= 1.0
%   -5.0 <= x_i <= 5.0 (i = 2, 3, ..., n)
%   The 91.0 is 1 + 10 * (n - 1) with n = 10, so it assumes nreal = 10.
%
%   The objectives are written into columns nreal+1 : nreal+nobj.
%
%   Use it with input_data/zdt4.in.

global nreal ;

f1 = parent_pop(:,1);
gvals = parent_pop(:,2:nreal);
g = (gvals .* gvals) - (10 .* cos(4.0 .* pi .* gvals)); 
g = sum(g,2);
g = 91.0 + g ;
h = ones(length(g),1) - sqrt(f1./g);
f2 = g .* h ;
parent_pop(:, (nreal+1)) = f1;
parent_pop(:, (nreal+2)) = f2;

end