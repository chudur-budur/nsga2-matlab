function [parent_pop] = srn(parent_pop)
%SRN  Srinivas and Deb's test problem, 2 objectives, 2 constraints.
%
%   parent_pop = srn(parent_pop) evaluates every row of
%   parent_pop at once.
%
%   This procedure implements srn (Srinivas and Deb's) function.
%   The canonical srn function is defined as below --
%       f1 = 2.0 + ((x_1 - 2.0)^2.0) + ((x_2 - 1.0)^2.0)
%       f2 = (9.0 * x_1) - ((x_2 - 1.0) ^ 2.0)
%       s.t.
%           c_1(x) = 1.0 - ((x_1^2.0) + (x_2^2.0))/225.0
%           c_2(x) = (3.0 * x_2/10.0) - (x_1/10.0) - 1.0
%       where
%           -20.0 <= x_i <= 20.0    (i = 1,2)
%
%   The objectives are written into columns nreal+1 : nreal+nobj.
%   The constraints are written into columns
%   nreal+nobj+1 : nreal+nobj+ncon, normalized so that a value
%   >= 0 means the constraint is satisfied.
%
%   Use it with input_data/srn.in.

global nreal ;
global ncon ;
global nobj ;

cindex = nreal + nobj + 1 : nreal + nobj + ncon ;

x = parent_pop(:,1:nreal);
f1 = 2.0 + ((x(:,1) - 2.0) .^ 2.0) + ((x(:,2) - 1.0) .^ 2.0);
f2 = (9.0 .* x(:,1)) - ((x(:,2) - 1.0) .^ 2.0);

c = parent_pop(:,cindex) ;
c(:,1) = 1.0 - (((x(:,1) .^ 2.0) + (x(:,2) .^ 2.0)) ./ 225.0);
c(:,2) = (3.0 .* (x(:,2) ./ 10.0)) - (x(:,1) ./ 10.0) - 1.0 ;

parent_pop(:, (nreal+1)) = f1 ;
parent_pop(:, (nreal+2)) = f2 ;
parent_pop(:, cindex) = c ;
end

