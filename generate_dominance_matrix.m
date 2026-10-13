function [dom_mat] = generate_dominance_matrix(pop, indices)
%GENERATE_DOMINANCE_MATRIX  Pairwise dominance of the whole population.
%
%   dom_mat = generate_dominance_matrix(pop, indices) generate the
%   dominance matrix from the given population, all the pairs at once
%   without any loop. Entry (i,j) of the matrix part is --
%       1   if individual i dominates individual j
%      -1   if individual j dominates individual i
%       0   if they are non-dominated
%   It uses the same constrained-domination rules as check_dominance().
%
%   Inputs:
%       pop     = population matrix with n rows
%       indices = row indices of pop, 1:n
%   Output:
%       dom_mat = n-by-(n+1) matrix, the first column is indices and
%                 the rest is the n-by-n dominance matrix, so use
%                 dom_mat(:, j+1) for the j-th individual
%
%   This function is O(n^2) in both time and memory.
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
%
%   Globals used:
%       nreal, nbin, sumnbits, nobj, ncon

global nreal ;
global nbin ;
global sumnbits ;
global nobj ;
global ncon ;

% number of variable columns, real or binary
if(nreal > 0)
    nvar = nreal ;
elseif(nbin > 0)
    nvar = sumnbits ;
end

obj_col = nvar+1:nvar+nobj;
cv_col = nvar+nobj+ncon+1;

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
