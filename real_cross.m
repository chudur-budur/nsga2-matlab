function [ c_vec1, c_vec2 ] = real_cross( p_vec1, p_vec2, pcross_real,...
                                            eta_c, min_realvar, max_realvar)
%   Applies SBX over two vectors of double.

nreal = length(p_vec1);

epsilon = 1.0e-14 ;
% ncross = 0 ;

c_vec1 = zeros(1,nreal);
c_vec2 = zeros(1,nreal);

% This is the original implementation
% if (rand(1) <= pcross_real)
%     % ncross = ncross + 1;
%     for i = 1:nreal
%        if (rand(1) <= 0.5)
%            if (abs(p_vec1(i) - p_vec2(i)) > epsilon)
%                 if (p_vec1(i) < p_vec2(i))
%                     y1 = p_vec1(i) ;
%                     y2 = p_vec2(i) ;
%                 else
%                     y1 = p_vec2(i) ;
%                     y2 = p_vec1(i) ;
%                 end
%                 yl = min_realvar(i);
%                 yu = max_realvar(i);
%                 beta_ = 1.0 + (2.0 * (y1 - yl) / (y2 - y1));
% 				alpha_ = 2.0 - (beta_ ^ (-1.0 * (eta_c + 1.0)));
%                 r = rand(1) ;
%                 if (r <= (1.0 / alpha_))
% 						betaq = (r * alpha_) ^ (1.0/(eta_c + 1.0));
%                 else
% 						betaq = (1.0 / (2.0 - r * alpha_)) ^ (1.0 / (eta_c + 1.0));
%                 end
% 				c1 = 0.5 * ((y1 + y2) - (betaq * (y2 - y1)));
% 				beta_ = 1.0 + (2.0 * (yu - y2)/(y2 - y1));
% 				alpha_ = 2.0 - (beta_ ^ (-1.0 * (eta_c + 1.0)));
%                 if (r <= (1.0 / alpha_))
% 						betaq = (r * alpha_) ^ (1.0 / (eta_c + 1.0));
%                 else
% 						betaq = (1.0 / (2.0 - r * alpha_)) ^ (1.0 / (eta_c + 1.0));
%                 end
% 				c2 = 0.5 * ((y1 + y2) + betaq * (y2 - y1));
%                 if (c1 < yl)
% 					c1 = yl;
%                 end
%                 if (c2 < yl)
% 					c2 = yl;
%                 end				
%                 if (c1 > yu)
% 					c1 = yu;
%                 end				
%                 if (c2 > yu)
% 					c2 = yu;
%                 end				
%                 if (rand(1) <= 0.5)
% 					c_vec1(i) = c2;
% 					c_vec2(i) = c1;
%                 else
% 					c_vec1(i) = c1;
% 					c_vec2(i) = c2;
%                 end
%             else
%                 c_vec1(i) = p_vec1(i) ;
%                 c_vec2(i) = p_vec2(i) ;
%             end
%         else
%             c_vec1(i) = p_vec1(i) ;
%             c_vec2(i) = p_vec2(i) ;
%         end
%     end
% else
%     c_vec1 = p_vec1 ;
%     c_vec2 = p_vec2 ;
% end

% disp(cvec1)
% disp(cvec2)

% This is the vectorized version of the above code,
% this will give double speed up than the above one.
if(rand(1) <= pcross_real) 
    % ncross = ncross + len;
    randv1lthalf = rand(1,nreal) <  0.5 ;    
    absdiffgteps = abs(p_vec1 - p_vec2) > (zeros(1,nreal) * epsilon) ;    
    xover_index = randv1lthalf & absdiffgteps ;
    abs_xover_index = (1:length(xover_index));
    abs_xover_index = abs_xover_index(xover_index);
    p1 = p_vec1(xover_index);
    p2 = p_vec2(xover_index);
    len = length(p1);
    if(len > 0)
        eta_cv = ones(1, len) * eta_c ;
        rv = rand(1,len);       
        randv2lthalf = rand(1,len) < 0.5 ;
        %
        pveclt = p1 < p2 ;
        y1v = p1 .* pveclt + p2 .* (~pveclt);
        y2v = p1 .* (~pveclt) + p2 .* pveclt;
        ylv = min_realvar(xover_index).' ;
        yuv = max_realvar(xover_index).' ;
        %
        beta_v = 1.0 + (2.0 * (y1v - ylv) ./ (y2v - y1v));
        alpha_v = 2.0 - (beta_v .^ (-1.0 .* (eta_cv + 1.0)));
        rltalpha = rv <= (1.0 ./ alpha_v);
        betaqv = ((rv .* alpha_v) .^ (1.0 ./ (eta_cv + 1.0))) .* ... 
                    rltalpha + ((1.0 ./ (2.0 - rv .* alpha_v)) .^ ...
                        (1.0 ./ (eta_cv + 1.0))) .* (~rltalpha);
        c1v = 0.5 .* ((y1v + y2v) - (betaqv .* (y2v - y1v)));
        %
        beta_v = 1.0 + (2.0 * (yuv - y2v) ./ (y2v - y1v));
        alpha_v = 2.0 - (beta_v .^ (-1.0 .* (eta_cv + 1.0)));
        rltalpha = rv <= (1.0 ./ alpha_v);
        betaqv = ((rv .* alpha_v) .^ (1.0 ./ (eta_cv + 1.0))) .* ... 
                    rltalpha + ((1.0 ./ (2.0 - rv .* alpha_v)) .^ ...
                        (1.0 ./ (eta_cv + 1.0))) .* (~rltalpha);
        c2v = 0.5 .* ((y1v + y2v) + betaqv .* (y2v - y1v));
        %
        c1ltyl = c1v < ylv ;
        c1gtyu = c1v > yuv ;
        c1v = (c1ltyl .* ylv) + (c1v .* (~c1ltyl));
        c1v = (c1gtyu .* yuv) + (c1v .* (~c1gtyu));        
        c2ltyl = c2v < ylv ;
        c2gtyu = c2v > yuv ;
        c2v = (c2ltyl .* ylv) + (c2v .* (~c2ltyl));
        c2v = (c2gtyu .* yuv) + (c2v .* (~c2gtyu));        
        %        
        p1 = c2v .* randv2lthalf + c1v .* (~randv2lthalf);
        p2 = c1v .* randv2lthalf + c2v .* (~randv2lthalf);       
    end
    %
    c_vec1 = c_vec1' ;
    c_vec1(abs_xover_index.',1) = p1' ;
    c_vec1((~xover_index).',1) = p_vec1(~xover_index).' ;
    c_vec1 = c_vec1';
    %
    c_vec2 = c_vec2' ;
    c_vec2(abs_xover_index.',1) = p2' ;
    c_vec2((~xover_index).',1) = p_vec2(~xover_index).' ;
    c_vec2 = c_vec2' ;
    %
else
    c_vec1 = p_vec1 ;
    c_vec2 = p_vec2 ;    
end

end

