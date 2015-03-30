function [rmat] = rndrealv(row, col, low, high)
%   calls rndreal() over row,col dimensions.

rmat = zeros(row,col);
for r = 1:row
    for c = 1:col
        rmat(row,col) = rndreal(low,high);
    end
end
end

