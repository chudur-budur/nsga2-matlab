function [parent_pop] = tnk(parent_pop)
%   This procedure implements Tanaka's function.
%   The canonical Tanaka's function is defined as below --
%   f_1 = x_1 
%   f_2 = x-2
%   s.t.
%       c_1(x) = -1.0                                           if x_1 == 0.0
%       c_1(x) = (x_1 ^ 2.0) + (x_2 ^ 2.0)                      otherwise
%                   - (0.1 * cos(16.0 * atan(x_1/x_2))) - 1.0
%       c_2(x) = 1.0 - ((2.0 * (x_1 - 0.5) ^ 2.0) 
%                           + (2.0 * (x_2 - 0.5) ^2.0))
%   where
%        0 <= x_i <= 3.15, i = 1,2

global nreal ;
global ncon ;
global nobj ;

cindex = nreal + nobj + 1 : nreal + nobj + ncon ;

x = parent_pop(:,1:nreal);
f1 = x(:,1);
f2 = x(:,2);

c = parent_pop(:,cindex) ;
vals = (x(:,1) .^ 2.0) + (x(:,2) .^ 2.0) ...
                - (0.1 .* cos(16.0 .* atan(x(:,1) ./ x(:,2)))) - 1.0 ;
c(:,1) = ((x(:,1) == 0) .* -1.0) + ((x(:,1) ~= 0) .* vals) ;
c(:,2) = 1.0 - ((2.0 .* (x(:,1) - 0.5) .^ 2.0) + ...
                        (2.0 .* (x(:,2) - 0.5) .^ 2.0));

parent_pop(:, (nreal+1)) = f1 ;
parent_pop(:, (nreal+2)) = f2 ;
parent_pop(:, cindex) = c ;
end