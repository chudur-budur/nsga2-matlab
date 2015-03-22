function [ pop ] = assign_crowding_distance(pop, pf_indices)
%   This function assigns crowding distance within a front
%   pointed by the row indices in pf_indices. Code is a 
%   vectorized translation from the original nsga-2 c-code.
 
global nreal ;
global nobj ;

obj_col = nreal + 1 : nreal + nobj ;

% clear the CD values.
pop(pf_indices,end) = 0 ;

% This is the original nsga-2 c-code.
% front = pop(pf_indices,:);
% fmax = max(front(:,obj_col));
% fmin = min(front(:,obj_col));
% for f = 1:nobj
%     front = sortrows(front, nreal + f);
%     front(1,end) = inf ;
%     front(end,end) = inf ;
%     [l,~] = size(front);
%     for i = 2:l-1
%         if(front(i,end) ~= inf)
%             front(i,end) = front(i,end) + ...
%                 ((front(i+1,nreal+f) - front(i-1,nreal+f))/...
%                                 (fmax(f) - fmin(f)));
%         end
%     end
% end
% front(:,end) = front(:,end) / nobj ;
% % tester = front ;
% pop(pf_indices,:) = front ;
% % disp(front)

% Vectorized version of the above code, generally this is 10% faster, 
% however more gain could be observed when the number of individuals in a
% front gets bigger. 
len = length(pf_indices);
if(len == 1 || len == 2)
    pop(pf_indices,end) = inf ;
    return ;
elseif(len == 3)
    front = pop(pf_indices,:);
    for f = 1:nobj
        sorted_front = sortrows(front, nreal + f);
        % set the boundary values to inf
        sorted_front(1,end) = inf ;
        sorted_front(end,end) = inf ;
    end
    pop(pf_indices,:) = sorted_front ;
    return ;
else    
    front = pop(pf_indices,:);
    % front(:,end) = 0 ;
    fmax = max(front(:,obj_col));
    fmin = min(front(:,obj_col));
    for f = 1:nobj
        sorted_front = sortrows(front, nreal + f);
        % set the boundary values to inf
        sorted_front(1,end) = inf ;
        sorted_front(end,end) = inf ;
        % get the obj values only
        objvals = sorted_front(:, nreal+1:nreal+nobj);    
        % normalize the values
        objvals = bsxfun(@times, bsxfun(@minus, objvals, fmin),... 
                                    1./abs(fmax - fmin));    
        % get the manhattan distances in the complete graph
        manmat = sum(abs(bsxfun(@minus,permute(objvals,[1 3 2]), ...
                                       permute(objvals,[3 1 2]))),3);    
        % the CD values are the 2nd diagonal
        cds = diag(manmat,2) ;
        % update the CD values
        sorted_front(2:end-1,end) = sorted_front(2:end-1,end) + cds ;
    end
    sorted_front(:,end) = sorted_front(:,end) / nobj ;
    pop(pf_indices,:) = sorted_front ;
    % pprint('sorted_front:\n', sorted_front);
    % pprint('tester:\n', tester);
    % disp(sorted_front)
end

end