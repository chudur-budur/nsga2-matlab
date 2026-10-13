function [x] = decode(pop)
%DECODE  Converts the bits of every individual into real values.
%
%   x = decode(pop) decodes the binary variables of every row of pop,
%   same as decode_ind() in nsga2-c. The bits of each variable are read
%   as an unsigned integer, most significant bit first, and mapped
%   linearly onto [min_binvar, max_binvar] --
%       s   = sum_k bit_k * 2^(nbits - k)        (k = 1 .. nbits)
%       x_j = min_binvar + s * (max_binvar - min_binvar) / (2^nbits - 1)
%   so all zeros gives min_binvar and all ones gives max_binvar.
%
%   Input:
%       pop = population, the first sumnbits columns are the bits
%   Output:
%       x   = decoded values, one row per individual and one column per
%             binary variable (popsize x nbin)
%
%   Globals used:
%       nbin, nbits, sumnbits, min_binvar, max_binvar

global nbin ;
global nbits ;
global sumnbits ;
global min_binvar ;
global max_binvar ;

bits = pop(:, 1:sumnbits);
nb = nbits(:);

% which variable every bit belongs to, and its position inside it
offsets = [0; cumsum(nb)];
starts = zeros(sumnbits, 1);
starts(offsets(1:nbin) + 1) = 1;
vidx = cumsum(starts);
pos = (1:sumnbits)' - offsets(vidx);

% sumnbits x nbin weight matrix, column j holds the place values of
% variable j (most significant bit first) and zeros elsewhere, so
% bits * w gives the unsigned integer value of every variable at once
place = 2 .^ (nb(vidx) - pos);
w = full(sparse((1:sumnbits)', vidx, place, sumnbits, nbin));
s = bits * w;

% map the integers linearly onto [min_binvar, max_binvar], multiplying
% before dividing like the c-code so the results match it exactly
vrange = (max_binvar(:) - min_binvar(:))';
x = bsxfun(@plus, min_binvar(:)', ...
        bsxfun(@rdivide, bsxfun(@times, s, vrange), (2 .^ nb' - 1)));

end
