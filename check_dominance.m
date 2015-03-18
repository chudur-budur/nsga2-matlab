function [ val ] = check_dominance(vec1, vec2)
%   This procedure checks the dominance of two vectors,
%   where the vectors are in the form [obj,cv]
%   The non-domnination check will work like this --
%       1   if vec1 dominates vec2
%      -1   if vec2 dominates vec1
%       0   if both vec1 and vec2 are non-dominated
%
%   Please note: Vectorization on this function may not be too
%   efficient as it operates on only two vectors, and couple of
%   variables.

% split the obj and cv values 
obj1 = vec1(1:end-1);
cv1 = vec1(end);
obj2 = vec2(1:end-1);
cv2 = vec2(end);

if(cv1 < 0 && cv2 < 0)
    if(cv1 > cv2)
        val = 1 ;
        return ;
    elseif(cv1 < cv2)
        val = -1 ;
        return ;
    else
        val = 0;
        return ;
    end
else
    if(cv1 < 0 && cv2 == 0)
        val = -1 ;
        return ;
    elseif(cv1 == 0 && cv2 < 0)
        val = 1  ;
        return ;
    else
        if(all(obj1 > obj2))
            val = -1 ;
            return ;
        elseif(all(obj1 < obj2))      
            val = 1 ;
            return ;
        else
            val = 0 ;
            return ;
        end
    end
end
% end of check_dominance
end

function flag1(

