rand
=====

This is the rng described in the D.E. Knuth's book. Ported from the legacy nsga2 code
implemented in c. This code is not vectorized at all, just implemented to check if the
results from this matlab version exactly matches with the original nsga2 code (per 
random state or generation wise). Please do not use this rng if the speed is your main
concern, however, if you are worried about the validity of the results generated from
this matlab code, you can use it.

To use, remove all matlab rng function calls (rand(), randperm etc.) and replace them 
with the functions from these scripts. 
