function [parent_pop] = zdt5(parent_pop)
%   This procedure implements zdt5 function.
%   The canonical zdt5 function is defined as below --


global nbin ;
global nbits ;

nb = sum(nbits);

b = parent_pop(:,1:nb);

f1 = sum(b(:,1:nb) == 1, 2);
f2 = sum(b(:,1:nb) == 0, 2);

parent_pop(:, (nb+1)) = f1;
parent_pop(:, (nb+2)) = f2;

end