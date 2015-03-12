function [ cvec1, cvec2 ] = real_cross( pvec1, pvec2 )
%   Applies SBX over two vectors of double.
%   This code can be vectorized in a good way.

global nreal ;
global pcross_real ;
global min_realvar ;
global max_realvar ;
global eta_c ;

epsilon = 1.0e-14 ;

cvec1 = zeros(1,nreal);
cvec2 = zeros(1,nreal);
rp = rand(5);

if (rp(1) <= pcross_real)
    for i = 1:nreal
       if (rp(2) <= 0.5)
           if (abs(pvec1(i) - pvec2(i)) > epsilon)
                if (pvec1(i) < pvec2(i))
                    y1 = pvec1(i) ;
                    y2 = pvec2(i) ;
                else
                    y1 = pvec2(i) ;
                    y2 = pvec1(i) ;
                end
                yl = min_realvar(i);
                yu = max_realvar(i);
                beta_ = 1.0 + (2.0 * (y1 - yl) / (y2 - y1));
				alpha_ = 2.0 - (beta_ ^ (-1.0 * (eta_c + 1.0)));				
                if (rp(3) <= (1.0 / alpha_))
						betaq = (rp(3) * alpha_) ^ (1.0/(eta_c + 1.0));
                else
						betaq = (1.0 / (2.0 - rp(3) * alpha_)) ^ (1.0 / (eta_c + 1.0));
                end
				c1 = 0.5 * ((y1 + y2) - (betaq * (y2 - y1)));
				beta_ = 1.0 + (2.0 * (yu - y2)/(y2 - y1));
				alpha_ = 2.0 - (beta_ ^ (-1.0 * (eta_c + 1.0)));				
                if (rp(3) <= (1.0 / alpha_))
						betaq = (rp(3) * alpha_) ^ (1.0 / (eta_c + 1.0));
                else
						betaq = (1.0 / (2.0 - rp(3) * alpha_)) ^ (1.0 / (eta_c + 1.0));
                end
				c2 = 0.5 * ((y1 + y2) + betaq * (y2 - y1));
                if (c1 < yl)
					c1 = yl;
                end
                if (c2 < yl)
					c2 = yl;
                end				
                if (c1 > yu)
					c1 = yu;
                end				
                if (c2 > yu)
					c2 = yu;
                end				
                if (rp(4) <= 0.5)
					cvec1(i) = c2;
					cvec2(i) = c1;
                else
					cvec1(i) = c1;
					cvec2(i) = c2;
                end
            else
                cvec1(i) = pvec1(i) ;
                cvec2(i) = pvec2(i) ;
            end
        else
            cvec1(i) = pvec1(i) ;
            cvec2(i) = pvec2(i) ;
        end
    end
else
    cvec1 = pvec1 ;
    cvec2 = pvec2 ;
end

% disp(cvec1)
% disp(cvec2)


end

