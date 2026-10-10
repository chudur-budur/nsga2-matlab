function [ val ] = check_dominance(vec1, vec2)
%CHECK_DOMINANCE  Constrained dominance check between two individuals.
%
%   val = check_dominance(vec1, vec2) compares two individuals, where
%   the vectors are in the form [obj,cv]
%   The non-domnination check will work like this --
%       1   if vec1 dominates vec2
%      -1   if vec2 dominates vec1
%       0   if both vec1 and vec2 are non-dominated
%
%   The rules are the constrained-domination rules of NSGA-II --
%       - both infeasible (cv < 0): the smaller violation wins
%       - one feasible, one infeasible: the feasible one wins
%       - both feasible: the usual Pareto dominance on the objectives,
%         all objectives are minimized
%
%   This is the two-individual version used by tournament(), see
%   generate_dominance_matrix() for the whole-population version.
%
%   Please note: Vectorization on this function may not be too
%   efficient as it operates on only two vectors, and couple of
%   variables.

% split the obj and cv values 
obj1 = vec1(1:end-1);
cv1 = vec1(end);
obj2 = vec2(1:end-1);
cv2 = vec2(end);

% both infeasible, compare the violations
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
    % only one is infeasible, the feasible one wins
    if(cv1 < 0 && cv2 == 0)
        val = -1 ;
        return ;
    elseif(cv1 == 0 && cv2 < 0)
        val = 1  ;
        return ;
    else
        % both feasible, check the pareto dominance
        if(any(obj1 < obj2) && ~(any(obj1 > obj2)))
            val = 1 ;
        elseif(~(any(obj1 < obj2)) && any(obj1 > obj2))           
            val = -1 ;
        else
            val = 0 ;
            return ;
        end
    end
end
% end of check_dominance
end
