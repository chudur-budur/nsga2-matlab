function [rmat] = randompercv(row, col)
%   This function calls randomperc() over row,col dimensions.

rmat = zeros(row, col);
for r = 1:row
    for c = 1:col        
        rmat(r,c) = randomperc();
    end
end
end

