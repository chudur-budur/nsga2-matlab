function [ val ] = check_dominance(obj1, cv1, obj2, cv2)
%   This procedure checks the dominance of two rows w.r.t.
%   obj1/cv1 and obj2/cv2.
%   The non-domnination check will work like this --
%       1   if row1 dominates row2
%      -1   if row2 dominates row1
%       0   if both row1 and row2 are non-dominated

% disp(cv1)
% disp(cv2)
% disp(obj1)
% disp(obj2)

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

