function [ c_vec1, c_vec2 ] = bin_cross( p_vec1, p_vec2, nbits, pcross_bin)
%BIN_CROSS  Two-point crossover for binary variables.
%
%   [c_vec1, c_vec2] = bin_cross(p_vec1, p_vec2, nbits,
%   pcross_bin) applies two-point crossover to each binary variable
%   separately, same as bincross() in nsga2-c. For every variable, with
%   probability pcross_bin, two cut sites are picked at random inside
%   that variable and the bits between them are swapped between the
%   parents. Otherwise that variable is copied as it is.
%
%   Inputs:
%       p_vec1, p_vec2 = parent bit vectors (row vectors, sumnbits long)
%       nbits          = number of bits of each binary variable
%       pcross_bin     = crossover probability, per variable
%   Outputs:
%       c_vec1, c_vec2 = child bit vectors
%
%   Like the c-code, the sites are drawn from the first nbits(i) - 1
%   bits and the swap stops just before site2, so the last bit of each
%   variable is never swapped.

c_vec1 = p_vec1 ;
c_vec2 = p_vec2 ;

% start offset of each variable in the bit vector
offsets = [0; cumsum(nbits(:))];

for i = 1:length(nbits)
    if(rand(1) <= pcross_bin)
        % pick the two cut sites inside variable i, site1 <= site2
        site1 = randi([1, nbits(i)], 1);
        site2 = randi([1, nbits(i)], 1);
        if(site1 > site2)
            temp = site1;
            site1 = site2;
            site2 = temp;
        end
        % swap bits site1 .. site2-1 of variable i
        idx = offsets(i) + (site1 : site2 - 1);
        c_vec1(idx) = p_vec2(idx) ;
        c_vec2(idx) = p_vec1(idx) ;
    end
end

end
