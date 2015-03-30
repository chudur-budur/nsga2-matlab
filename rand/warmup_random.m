function [] = warmup_random(seed)
%   Get randomize off and running

global oldrand ;
global jrand ;

oldrand(55) = seed ;
new_random = 0.000000001; 
prev_random = seed ;

for j1 = 1:54
    ii = mod((21 * j1), 54);   
    oldrand(ii+1) = new_random;
    new_random = prev_random - new_random;
    if(new_random < 0.0)        
        new_random = new_random + 1.0;
    end
    prev_random = oldrand(ii+1);
end
advance_random();
advance_random();
advance_random();
jrand = 0 ;
end

