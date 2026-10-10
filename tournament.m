function [ sindex ] = tournament(pop, index1, index2)
%TOURNAMENT  Binary tournament between two individuals.
%
%   sindex = tournament(pop, index1, index2) returns the row index
%   (index1 or index2) of the winner, picked in this order --
%       1. the one that dominates the other (see check_dominance(),
%          which also handles the constraints)
%       2. the one with the larger crowding distance
%       3. a random one, if they are still tied
%
%   Inputs:
%       pop    = population matrix, crowding distance in the last column
%       index1 = row index of the first individual
%       index2 = row index of the second individual
%   Output:
%       sindex = index1 or index2
%
%   Vectorization on this function may not give better speed, so beter
%   to keep as it is.
%
%   Globals used:
%       nreal, nobj, ncon

global nreal ;
global nobj ;
global ncon ;

obj_col = nreal+1:nreal+nobj;
cv_col = nreal+nobj+ncon+1;

% check the dominance
flag = check_dominance([pop(index1,obj_col), pop(index1,cv_col)], ...
                       [pop(index2,obj_col), pop(index2,cv_col)]);

cdist1 = pop(index1, end);
cdist2 = pop(index2, end);
% the dominating one wins
if (flag == 1)
    sindex = index1 ;
    return ;
end
if(flag == -1)
    sindex = index2 ;
    return ;
end
% non-dominated, so the less crowded one wins
if(cdist1 > cdist2)
    sindex = index1 ;
    return ;
end
if(cdist2 > cdist1)
    sindex = index2 ;
    return ;
end
% still a tie, pick one at random
if(rand(1) < 0.5)
    sindex = index1 ;
    return ;
else
    sindex = index2 ;
    return ;
end

