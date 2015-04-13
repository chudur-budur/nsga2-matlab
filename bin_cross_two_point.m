function [ c_vec1, c_vec2 ] = bin_cross_two_point( p_vec1, p_vec2, nbits, pcross_bin)
%   Applies two-point crossover over two binary vectors.

vlen = length(p_vec1);
disp(nbits)

% ncross = 0 ;

if(rand(1) <= pcross_bin) 
% if(randomperc() <= pcross_real) % SLOW !!!
    % ncross = ncross + 1 ;
    site1 = randi([1, vlen], 1);
    % site1 = rnd(1,nb); % SLOW !!!
    site2 = randi([1, vlen], 1);
    % site2 = rnd(1,nb); % SLOW !!!
    if(site1 > site2)
        temp = site1;
        site1 = site2;
        site2 = temp;
    end
    c_vec1 = [p_vec1(:,1:site1), p_vec2(:,site1+1:site2), p_vec1(:,site2+1:end)]
    c_vec2 = [p_vec2(:,1:site1), p_vec1(:,site1+1:site2), p_vec2(:,site2+1:end)]
else
    c_vec1 = p_vec1 ;
    c_vec2 = p_vec2 ;    
end
end

