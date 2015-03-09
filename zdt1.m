function [parent_pop] = zdt1(parent_pop)
%   This function implements zdt1 function.

global nreal ;

f1 = parent_pop(:,1);
gvals = parent_pop(:,2:nreal);
g = sum(gvals,2);
g = (g * 9.0) / (nreal-1) ;
g = 1.0 + g ;
onez = ones(length(g),1);
h = onez - sqrt(f1./g);
f2 = g .* h ;
parent_pop(:, (nreal+1)) = f1;
parent_pop(:, (nreal+2)) = f2;

end