function [ pop ] = assign_crowding_distance(pop, pf_indices)
%   This function assigns crowding distance within a front
%   pointed by the row indices in pf_indices. Code is currently
%   a direct translation from the original nsga-2 c-code.
%   OPTIMIZATION NEEDED.
 
global nreal ;
global nobj ;

fstarti = nreal + 1 ;
fendi = nreal + nobj ;
[~,cdisti] = size(pop);

submat = pop(pf_indices,:);
for f = 1:nobj
    fmax = max(submat(:,fstarti:fendi));
    fmin = min(submat(:,fstarti:fendi));
    submat = sortrows(submat, nreal + f);
    submat(1,cdisti) = inf ;
    submat(end,cdisti) = inf ;
    [l,~] = size(submat);
    for i = 2:l-1
        if(submat(i,cdisti) ~= inf)
            submat(i,cdisti) = submat(i,cdisti) + ...
                ((submat(i+1,nreal+f) - submat(i-1,nreal+f))/...
                                (fmax(f) - fmin(f)));
        end
    end
end
pop(pf_indices,:) = submat ;
end

