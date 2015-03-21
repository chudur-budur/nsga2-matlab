function [dom_mat] = generate_dominance_matrix(pop, indices)
%   Generate the dominance matrix from the given population.
%   This function is O(n^2).
%
%     |   *c    *d
%     |
%     |   *a    *b
%    _|_______________
%     |
%   
%   For the above objective values, the dominance matrix 
%   will look like this --
%   
%       A   B   C   D
%   A   0   0   1   1
%   B   0   0   0   1
%   C  -1   0   0   0
%   D  -1  -1   0   0

global nreal ;
global nobj ;
global ncon ;

obj_col = nreal+1:nreal+nobj;
cv_col = nreal+nobj+ncon+1;

% collect the relevant column data from input array
cv = pop(:,cv_col);
objmat = pop(:,obj_col);

% logical array corrresponding to starting if conditional --
ifcvbothzero = bsxfun(@and, cv < 0, cv.' < 0);

% create logical arrays corresponding to the next if-else's
ifcvnoteq = bsxfun(@minus, bsxfun(@gt, cv, cv.'), bsxfun(@lt, cv, cv.'));
ifanycvzero = bsxfun(@plus, -bsxfun(@and, cv < 0, cv.' == 0), ...
                        bsxfun(@and, cv == 0, cv.' < 0));

% build the matrix for the flag1 and flag2 
% flag1 = bsxfun(@lt, objmat(:,1), objmat(:,1).'); 
% flag2 = bsxfun(@gt, objmat(:,1), objmat(:,1).'); 
% for f = 2:nobj % can we get rid of this loop ?
%     flag1 = flag1 | bsxfun(@lt, objmat(:,f), objmat(:,f).');
%     flag2 = flag2 | bsxfun(@gt, objmat(:,f), objmat(:,f).');
% end
% This is the loop free version, it's 2 times faster than the loop !!
flag1 = any(bsxfun(@lt,permute(objmat,[1 3 2]),permute(objmat,[3 1 2])),3);
flag2 = any(bsxfun(@gt,permute(objmat,[1 3 2]),permute(objmat,[3 1 2])),3);

% now build flag2
flag2 = flag2 & ~flag1 ;

% next build the dominance flag matrix
dom_flag = bsxfun(@minus, bsxfun(@and, flag1 == 1, flag2 == 0), ...
    bsxfun(@and, flag1 == 0, flag2 == 1));
        
% collect the output taking care of all the conditionals
dom_mat = bsxfun(@plus, (bsxfun(@times, ifcvbothzero, ifcvnoteq)), ...
            (bsxfun(@times, (~ifcvbothzero), ...
                (bsxfun(@plus, ifanycvzero, ...
                    bsxfun(@times, (ifanycvzero == 0), dom_flag))))));
% the final dominance matrix
dom_mat = [indices', dom_mat] ;
end
