function [rval] = rndreal(low, high)
% Fetch a single real valued random number between 
% low and high inclusive
rval = low + ((high - low) * randomperc()) ;
end

