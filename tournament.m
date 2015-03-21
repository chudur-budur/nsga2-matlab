function [ sindex ] = tournament(pop, index1, index2)
%   Apply tournament selection to row indexed by index1 and index2
%   Vectorization on this function may not give better speed, so beter
%   to keep as it is.

global nreal ;
global nobj ;
global ncon ;

obj_col = nreal+1:nreal+nobj;
cv_col = nreal+nobj+ncon+1;
% disp(index1)
% disp(index2)
% disp([pop(index1,obj_col), pop(index1,cv_col)])
% disp([pop(index2,obj_col), pop(index2,cv_col)])
flag = check_dominance([pop(index1,obj_col), pop(index1,cv_col)], ...
                       [pop(index2,obj_col), pop(index2,cv_col)]);
cdist1 = pop(index1, end);
cdist2 = pop(index2, end);
if (flag == 1)
    sindex = index1 ;
    return ;
end
if(flag == -1)
    sindex = index2 ;
    return ;
end
if(cdist1 > cdist2)
    sindex = index1 ;
    return ;
end
if(cdist2 > cdist1)
    sindex = index2 ;
    return ;
end
if(rand(1) < 0.5)
    sindex = index1 ;
    return ;
else
    sindex = index2 ;
    return ;
end

