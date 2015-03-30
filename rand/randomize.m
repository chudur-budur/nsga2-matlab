function [] = randomize()
%   Initialize the rng.

global oldrand ;
global jrand ;
global seed ;

oldrand = zeros(1,55);

for j1 = 0:54
    oldrand(j1 + 1) = 0.0;
end
jrand = 0 ;
warmup_random(seed);
end

