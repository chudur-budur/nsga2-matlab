function [ pop ] = assign_crowding_distance(pop, pf_indices)
%   This function assigns crowding distance within a front
%   pointed by the row indices in pf_indices. Code is currently
%   a direct translation from the original nsga-2 c-code.
%   ** VECTORIZATION NEEDED and THIS CODE IS NOT RIGHT
 
global nreal ;
global nobj ;

obj_col = nreal + 1 : nreal + nobj ;

fmax = max(pop(:,obj_col));
fmin = min(pop(:,obj_col));
submat = pop(pf_indices,:);
submat(:,end) = 0 ;
for f = 1:nobj
    submat = sortrows(submat, nreal + f);
    submat(1,end) = inf ;
    submat(end,end) = inf ;
    [l,~] = size(submat);
    for i = 2:l-1
        if(submat(i,end) ~= inf)
            submat(i,end) = submat(i,end) + ...
                ((submat(i+1,nreal+f) - submat(i-1,nreal+f))/...
                                (fmax(f) - fmin(f)));
        end
    end
    % pprint('submat here:\n', submat);
end
submat(:,end) = submat(:,end)/nobj ;
% pprint('submat here-1:\n', submat);
pop(pf_indices,:) = submat ;

% VECTORIZED VERSION OF THE ABOVE CODE
% submat = pop(pf_indices,obj_col);
% % disp(submat)
% if(length(pf_indices) > 1)
%     cells = num2cell(submat,1) ;
%     normalized = cellfun(@(x) (x - min(x))/(max(x) - min(x)), cells, 'uniform', false) ;
%     manmat = mandist(cell2mat(normalized).') ;
%     % disp(manmat)
%     dists = diag(manmat,2); 
%     dists = dists/nobj ;
%     dists = [dists;inf]; 
%     dists = [inf;dists];
%     % disp(dists)
% else
%     dists = inf ;
% end
% pop(pf_indices,end) = dists ; 
% % disp(pop)

end