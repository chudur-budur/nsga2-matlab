function [parent_pop] = bnh(parent_pop)
%   This procedure implements bnh (Binh and Korn's) function.
%   The canonical bnh function is defined as below --
%   f_1 = 4.0 * (x_1^2 + x_2^2)
%   f_2 = (x_1 - 5)^2 + (x_2 - 5)^2
%   s.t.
%       c_1(x) = 1.0 - ((x_1 - 5)^2 + x_2^2)/25.0;
%       c_2(x) = ((x_1 - 8)^2 + (x_2 + 3)^2)/7.7 - 1.0;
%   where
%       0 <= x_1 <= 5.0
%       0 <= x_2 <= 3.0

global nreal ;
global ncon ;
global nobj ;

cindex = nreal + nobj + 1 : nreal + nobj + ncon ;

x = parent_pop(:,1:nreal);
f1 = 4.0 .* ((x(:,1) .^ 2.0) + (x(:,2) .^ 2.0));
f2 = ((x(:,1) - 5.0) .^ 2.0) + ((x(:,2) - 5.0) .^ 2.0);

c = parent_pop(:,cindex) ;
c(:,1) = 1.0 - ((((x(:,1) - 5.0) .^ 2.0) + (x(:,2) .^ 2.0)) ./ 25.0);
c(:,2) = ((((x(:,1) - 8.0) .^ 2.0) + ((x(:,2) + 3.0) .^ 2.0)) ./ 7.7) - 1.0 ;

parent_pop(:, (nreal+1)) = f1 ;
parent_pop(:, (nreal+2)) = f2 ;
parent_pop(:, cindex) = c ;
end

