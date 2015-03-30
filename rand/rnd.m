function [res] = rnd(low, high)
%   Fetch a single integer random number between 
%   low and high inclusive

if (low >= high)   
    res = low;
else
    res = round(low + (randomperc() * (high - low + 1)));
    if (res > high)
        res = high;
    end
end
end

