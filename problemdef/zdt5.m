function [parent_pop] = zdt5(parent_pop)
%ZDT5  ZDT5 test problem, 2 objectives, binary variables.
%
%   parent_pop = zdt5(parent_pop) evaluates every row of
%   parent_pop at once.
%
%   This procedure implements zdt5 function.
%   The canonical zdt5 function is defined as below --
%   f_1 = 1 + u(x_1)
%   f_2 = g / f_1
%   g(x_2, x_3, ..., x_n) = sum_{i = 2}^n v(u(x_i))
%   v(u) = 2 + u   if u < 5
%        = 1       if u == 5
%   where u(x_i) is the number of ones in x_i, x_1 has 30 bits and
%   every other x_i has 5 bits.
%
%   Ported from test_problem() for zdt5 in nsga2-c (problemdef.c), with
%   one deliberate fix: the c-code counts only the first 4 bits of each
%   5 bit variable (j < 4), so u(x_i) never reaches 5 and v(u) = 1 never
%   happens. Here all the bits of every variable are counted, as in the
%   published definition.
%
%   The objectives are written into columns sumnbits+1 : sumnbits+nobj.
%
%   Use it with input_data/zdt5.in.


global nbin ;
global nbits ;
global sumnbits ;

b = parent_pop(:,1:sumnbits);

% u(x_i) = number of ones in each binary variable
edges = [0; cumsum(nbits)];
u = zeros(size(b,1), nbin);
for i = 1:nbin
    u(:,i) = sum(b(:,edges(i)+1:edges(i+1)), 2);
end

f1 = 1.0 + u(:,1);
% v(u) = 2 + u, or 1 when all the bits of x_i are ones
v = 2 + u(:,2:nbin);
v(bsxfun(@eq, u(:,2:nbin), nbits(2:nbin)')) = 1;
g = sum(v, 2);
f2 = g ./ f1;

parent_pop(:, (sumnbits+1)) = f1;
parent_pop(:, (sumnbits+2)) = f2;

end
