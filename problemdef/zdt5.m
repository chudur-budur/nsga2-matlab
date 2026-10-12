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
%   Note: this is still a placeholder, the code below does not
%   implement the above yet. It simply counts the ones (f_1) and the
%   zeros (f_2) over all the bits.
%
%   The objectives are written into columns sumnbits+1 : sumnbits+nobj.
%
%   Use it with input_data/zdt5.in.


global nbin ;
global sumnbits ;

nb = sumnbits;

b = parent_pop(:,1:nb);

f1 = sum(b(:,1:nb) == 1, 2);
f2 = sum(b(:,1:nb) == 0, 2);

parent_pop(:, (nb+1)) = f1;
parent_pop(:, (nb+2)) = f2;

end