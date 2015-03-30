function [rmat] = rndv(row, col, low, high)
%   This function calls rnd() over row,col dimension

rmat = zeros(row,col);
for r = 1:row
    for c = 1:col
        rmat(r,c) = rnd(low, high);
    end
end
end

