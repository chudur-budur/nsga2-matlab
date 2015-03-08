function [parent_pop] = zdt1(parent_pop, nreal, nobj)
%ZDT1 Summary of this function goes here
%   Detailed explanation goes here

f1 = parent_pop(:,1);
if nreal == 2 
    g = parent_pop(:,2:nreal);
else
    gvals = parent_pop(:,2:nreal)';
    g = sum(gvals,1);
    g = g'; 
end
g = (g * 9.0) / (nreal-1) ;
g = 1.0 + g ;
onez = ones(length(g),1);
h = onez - sqrt(f1./g);
f2 = g .* h ;
parent_pop(:, (nreal+1)) = f1;
parent_pop(:, (nreal+2)) = f2;
end

