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

% start offset of each variable in the bit vector
offsets = [0; cumsum(nbits(:))];

x = zeros(size(pop, 1), nbin);
for j = 1:nbin
    % place values of the bits, most significant bit first
    w = 2 .^ (nbits(j)-1 : -1 : 0)';
    s = bits(:, offsets(j)+1 : offsets(j+1)) * w;
    x(:, j) = min_binvar(j) + s * (max_binvar(j) - min_binvar(j)) ...
                                / (2^nbits(j) - 1);
end

end
