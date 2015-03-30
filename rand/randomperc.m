function [rval] = randomperc()
%   Fetch a single random number between 0.0 and 1.0

global jrand;
global oldrand

jrand = jrand + 1;
if(jrand >= 55)
    jrand = 1;
    advance_random();
end
rval = oldrand(jrand+1);
end

