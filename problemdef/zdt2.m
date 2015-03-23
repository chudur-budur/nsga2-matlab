function [parent_pop] = zdt2(parent_pop)
%   This procedure implements zdt1 function.
%   The canonical zdt1 function is defined as below --
%   f_1 = x_1
%   f_2 = g * (1.0 - (f_1/g)^2)
%   g(x_2, x_3, ..., x_n) = 1.0 + (9/(n - 1)) sum_{i = 2}^n x_i
%   0 <= x_i <= 1.0 (i = 1, 2, 3, ..., n)


global nreal ;

f1 = parent_pop(:,1);
gvals = parent_pop(:,2:nreal);
g = sum(gvals,2);
g = (g .* 9.0) ./ (nreal-1) ;
g = 1.0 + g ;
h = ones(length(g),1) - ((f1 ./ g) .^ 2.0);
f2 = g .* h ;
parent_pop(:, (nreal+1)) = f1;
parent_pop(:, (nreal+2)) = f2;

end