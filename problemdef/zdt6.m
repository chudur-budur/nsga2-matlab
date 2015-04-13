function [parent_pop] = zdt6(parent_pop)
%   This procedure implements zdt6 function.
%   The canonical zdt6 function is defined as below --
%   f_1 = 1.0 - exp(-4.0 * x_1) * sin(6 * pi * x_1)
%   f_2 = g * (1.0 - (f_1/g)^2)
%   g(x_2, x_3, ..., x_n) = 1.0 + 9.0 * ((sum_{i = 2}^n x_i)/9.0)^0.25
%   0 <= x_i <= 1.0 (i = 1, 2, 3, ..., n)


global nreal ;

x1 = parent_pop(:,1);
f1 = 1.0 - (exp(-4.0 .* x1) .* (sin(6.0 .* pi .* x1) .^ 6.0));
gvals = parent_pop(:,2:nreal);
g = sum(gvals,2);
g = g ./ 9.0 ;
g = g .^ 0.25 ;
g = 1.0 + (9.0 .* g) ;
h = ones(length(g),1) - ((f1./g) .^ 2.0);
f2 = g .* h ;
parent_pop(:, (nreal+1)) = f1;
parent_pop(:, (nreal+2)) = f2;

end