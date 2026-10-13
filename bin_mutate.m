function [pvec] = bin_mutate(pvec, pmut_bin)
%BIN_MUTATE  Bit-flip mutation for binary variables.
%
%   pvec = bin_mutate(pvec, pmut_bin) flips every bit of pvec
%   independently with probability pmut_bin, same as bin_mutate_ind()
%   in nsga2-c.
%
%   Inputs:
%       pvec     = row vector of bits, sumnbits long
%       pmut_bin = mutation probability per bit
%   Output:
%       pvec     = mutated row vector

flip = rand(size(pvec)) <= pmut_bin ;
pvec(flip) = 1 - pvec(flip) ;

end
