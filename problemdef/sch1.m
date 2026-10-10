function [parent_pop] = sch1(parent_pop)
%SCH1  Schaffer's first test problem, 2 objectives.
%
%   parent_pop = sch1(parent_pop) evaluates every row of
%   parent_pop at once.
%
%   This procedure implements sch1 (Schaffer's) function.
%   The canonical sch1 function is defined as below --
%
%   f_1 = x_1^2
%   f_2 = (x_1 - 2)^2
%   where
%       -10.0 <= x_1 <= 10.0
%
%   The objectives are written into columns nreal+1 : nreal+nobj.
%
%   Use it with input_data/sch1.in.

global nreal ;

x = parent_pop(:,1:nreal);
f1 = x(:,1) .^ 2.0 ;
f2 = (x(:,1) - 2.0) .^ 2.0 ;


parent_pop(:, (nreal+1)) = f1 ;
parent_pop(:, (nreal+2)) = f2 ;
end

