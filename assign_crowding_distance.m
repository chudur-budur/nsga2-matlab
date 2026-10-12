function [ pop ] = assign_crowding_distance(pop, pf_indices)
%ASSIGN_CROWDING_DISTANCE  Crowding distance within one front.
%
%   pop = assign_crowding_distance(pop, pf_indices) assigns crowding
%   distance within a front pointed by the row indices in pf_indices,
%   and writes it in the last column of pop. This follows the NSGA-II
%   paper (Deb et al., 2002).
%
%   For each objective, the front is sorted on that objective, the two
%   boundary individuals get inf, and every other individual gets the
%   gap between its two neighbours, normalized by the range of that
%   objective in the front. The gaps are summed over all the objectives
%   and divided by nobj. An objective with zero range adds 0.
%
%   Fronts with one or two individuals get inf for everyone.
%
%   Note: the nsga2 c-code only sets inf on the minimum of each
%   objective, not the maximum. That is the same for 2 objectives but
%   not for 3 or more, here both ends get inf as in the paper.
%
%   Inputs:
%       pop        = population matrix
%       pf_indices = row indices of the individuals in the front
%   Output:
%       pop        = the same population with the crowd-dist column of
%                    the front filled in, the rows stay in place
%
%   Globals used:
%       nreal, nbin, nbits, nobj

global nreal ;
global nbin ;
global sumnbits ;
global nobj ;

if(nreal > 0)
    obj_col = nreal + 1 : nreal + nobj ;
elseif(nbin > 0)
    obj_col = sumnbits + 1 : sumnbits + nobj ;
end

len = length(pf_indices);
if(len <= 2)
    pop(pf_indices,end) = inf ;
    return ;
end

objvals = pop(pf_indices, obj_col);

% This is the looped version of the code below, kept for reference.
% fmin = min(objvals);
% fmax = max(objvals);
% cd = zeros(len,1);
% for f = 1:nobj
%     [sorted, idx] = sort(objvals(:,f));
%     cd(idx(1)) = inf ;
%     cd(idx(end)) = inf ;
%     if(fmax(f) > fmin(f))
%         for i = 2:len-1
%             cd(idx(i)) = cd(idx(i)) + ...
%                 ((sorted(i+1) - sorted(i-1)) / (fmax(f) - fmin(f)));
%         end
%     end
% end
% pop(pf_indices,end) = cd / nobj ;

% Vectorized version, all the objectives at once.
% the range of each objective, a zero range is set to inf so that
% its gaps become 0
frange = max(objvals) - min(objvals);
frange(frange == 0) = inf ;
% sort every objective column separately, idx(:,f) is the row order
% of the front on objective f
[sorted, idx] = sort(objvals, 1);
% normalized gap between the two neighbours of every inner position
gaps = bsxfun(@rdivide, sorted(3:end,:) - sorted(1:end-2,:), frange);
% put each gap back on the row it belongs to, one column per objective
cd = zeros(len, nobj);
cols = repmat(1:nobj, len-2, 1);
cd(sub2ind([len nobj], idx(2:end-1,:), cols)) = gaps ;
% the boundaries of every objective get inf
cols = repmat(1:nobj, 2, 1);
cd(sub2ind([len nobj], idx([1 end],:), cols)) = inf ;
% sum over the objectives, inf stays inf
pop(pf_indices,end) = sum(cd, 2) / nobj ;

end
