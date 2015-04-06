function [parent_pop] = osy(parent_pop)
%   This procedure implements Osyczka and Kundu's function.
%   The canonical zdt1 function is defined as below --
%   f_1 = -25.0 * ((x_1 - 2)^2 - (x_2 - 2)^2 - (x_3 - 1)^2 
%                           - (x_4 - 4)^2 - (x_5 - 1)^2)
%   f_2 = sum_{i=1}^n x_i^2.0
%   s.t.
%       c_1(x) = x_1 + x_2 - 2 >= 0
%       c_2(x) = 6 - x_1 - x_2 >= 0
%       c_3(x) = 2 - x_2 + x_1 >= 0
%       c_4(x) = 2 - x_1 + 3x_2 >= 0
%       c_5(x) = 4 - (x_3 - 3)^2 - x_4 >= 0
%       c_6(x) = (x_5 - 3)^2 + x_6 - 4 >= 0
%   where,
%       0 <= x_1 <= 10.0
%       0 <= x_2 <= 10.0
%       1 <= x_3 <= 5.0
%       0 <= x_4 <= 6.0
%       1 <= x_5 <= 5.0
%       0 <= x_6 <= 10.0

global nreal ;
global ncon ;
global nobj ;

cindex = nreal + nobj + 1 : nreal + nobj + ncon ;

% disp(parent_pop(1,:))

x = parent_pop(:,1:nreal);
f1 = -(25.0 .* ((x(:,1) - 2.0) .^ 2.0) + ((x(:,2) - 2.0) .^ 2.0) ...
             + ((x(:,3) - 1.0) .^ 2.0) + ((x(:,4) - 4.0) .^ 2.0) ... 
             + ((x(:,5) - 1.0) .^ 2.0));
f2 = sum((x .^ 2.0), 2) ;

c = parent_pop(:,cindex) ;
% disp(c(1,:))
c(:,1) = ((x(:,1) + x(:,2)) ./ 2.0) - 1.0 ;
c(:,2) = 1.0 - ((x(:,1) + x(:,2)) ./ 6.0);
c(:,3) = 1.0 - (x(:,2) ./ 2.0) + (x(:,1) ./ 2.0);
c(:,4) = 1.0 - (x(:,1) ./ 2.0) + (3.0 .* (x(:,2) ./ 2.0));
c(:,5) = 1.0 - (((x(:,3) - 3.0) .^ 2.0) ./ 4.0) - (x(:,4) ./ 4.0);
c(:,6) = (((x(:,5) - 3.0) .^ 2.0) ./ 4.0) + (x(:,6) ./ 4.0) - 1.0;
parent_pop(:, (nreal+1)) = f1;
parent_pop(:, (nreal+2)) = f2;
parent_pop(:,cindex) = c ;
end