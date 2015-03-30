function [] = advance_random()
%   Creates the next batch of 55 random numbers.

global oldrand ;

for j1 = 0:23
    new_random = oldrand(j1 + 1) - oldrand(j1 + 31 + 1);
    if (new_random < 0.0)
        new_random = new_random + 1.0 ;
    end
    oldrand(j1 + 1) = new_random ;
end

for j1 = 24:54
    new_random = oldrand(j1 + 1) - oldrand((j1 - 24) + 1);
    if (new_random < 0.0)
        new_random = new_random + 1.0 ;
    end
    oldrand(j1 + 1) = new_random ;
end
end

