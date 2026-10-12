function [ c_vec1, c_vec2 ] = bin_cross_two_point( p_vec1, p_vec2, nbits, pcross_bin)
%BIN_CROSS_TWO_POINT  Two-point crossover for binary variables.
%
%   [c_vec1, c_vec2] = bin_cross_two_point(p_vec1, p_vec2, nbits,
%   pcross_bin) applies two-point crossover over two binary vectors.
%   With probability pcross_bin, two cut sites are picked at random and
%   the bits between them are swapped between the parents. Otherwise
%   the children are copies of the parents.
%
%   Inputs:
%       p_vec1, p_vec2 = parent bit vectors (row vectors, sumnbits long)
%       nbits          = number of bits of each binary variable
%       pcross_bin     = crossover probability
%   Outputs:
%       c_vec1, c_vec2 = child bit vectors
%
%   Note: the binary encoding is still a work in progress.

vlen = length(p_vec1);
disp(nbits)

% ncross = 0 ;

if(rand(1) <= pcross_bin)
    % ncross = ncross + 1 ;
    % pick the two cut sites, site1 <= site2
    site1 = randi([1, vlen], 1);
    site2 = randi([1, vlen], 1);
    if(site1 > site2)
        temp = site1;
        site1 = site2;
        site2 = temp;
    end
    % swap the middle segment
    c_vec1 = [p_vec1(:,1:site1), p_vec2(:,site1+1:site2), p_vec1(:,site2+1:end)]
    c_vec2 = [p_vec2(:,1:site1), p_vec1(:,site1+1:site2), p_vec2(:,site2+1:end)]
else
    c_vec1 = p_vec1 ;
    c_vec2 = p_vec2 ;
end
end

