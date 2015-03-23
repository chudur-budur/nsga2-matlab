function [parent_pop] = zdt3(parent_pop)
%   This procedure implements zdt3 function.
%   The canonical zdt3 function is defined as below --
%   f_1 = x_1
%   f_2 = g * h
%   g(x_2, x_3, ..., x_n) = 1.0 + (9/(n - 1)) sum_{i = 2}^n x_i
%   h(f_1,g) = 1.0 - sqrt(f_1/g) - (f_1/g)*sin(10 * pi * f_1)
%   0 <= x_i <= 1.0 (i = 1, 2, 3, ..., n)

global nreal ;

f1 = parent_pop(:,1);
gvals = parent_pop(:,2:nreal);
g = sum(gvals,2);
g = (g .* 9.0) ./ (nreal-1) ;
g = 1.0 + g ;
h = ones(length(g),1) - sqrt(f1./g) - ((f1./g) .* sin(10 .* pi .* f1));
f2 = g .* h ;
parent_pop(:, (nreal+1)) = f1;
parent_pop(:, (nreal+2)) = f2;

end