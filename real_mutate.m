function [pvec] = real_mutate(pvec, pmut_real, eta_m, ...
                                min_realvar, max_realvar)
%   This code applies polynomical mutation over pvec.

nreal = length(pvec);

if(nreal < 1)
    pvec = polymut_looped(pvec, pmut_real, eta_m, ...
                            min_realvar, max_realvar);
else
    pvec = polymut_vectorized(pvec, pmut_real, eta_m, ...
                            min_realvar, max_realvar);
end
% pprint('pvec:\n', pvec);
end

function [pvec] = polymut_looped(pvec, pmut_real, eta_m, ...
                                    min_realvar, max_realvar)
% This is the original translation from the nsga-2 c-code.
nreal = length(pvec);
for j = 1:nreal
    if (rand(1) <= pmut_real)
        y = pvec(j);
        yl = min_realvar(j);
        yu = max_realvar(j);
        delta1 = (y-yl)/(yu-yl);
        delta2 = (yu-y)/(yu-yl);
        mut_pow = 1.0/(eta_m + 1.0);
        r = rand(1) ;
        if (r <= 0.5)
            xy = 1.0 - delta1;
            val = 2.0 * r + (1.0 - 2.0 * r) * (xy ^ (eta_m + 1.0));
            deltaq = (val ^ mut_pow) - 1.0;
        else
            xy = 1.0 - delta2;
            val = 2.0 * (1.0 - r) + 2.0 * (r - 0.5) * (xy ^ (eta_m + 1.0));
            deltaq = 1.0 - (val ^ mut_pow);
        end
        y = y + deltaq * (yu - yl);
        if (y < yl)
            y = yl;
        end
        if (y > yu)
            y = yu;
        end
        pvec(j) = y ;
    end
end
end

function [pvec] = polymut_vectorized(pvec, pmut_real, eta_m, ...
                                        min_realvar, max_realvar)
% This is the vectorized version of the above code. This code is generally 
% 3 times faster than the above, more gain could be observed if the number 
% of variable is bigger and the mutation rate is higher.
nreal = length(pvec);
mut_index = rand(1,nreal) < pmut_real ;
% mut_index = r1s < pmut_real ;
abs_mut_index = 1:nreal ;
abs_mut_index = abs_mut_index(mut_index);
mlen = length(abs_mut_index);
% pprint('mlen:\n', mlen);
if(mlen > 0)
    eta_mv = ones(1,mlen) * eta_m ;
    yv = pvec(mut_index) ;    
    ylv = min_realvar(mut_index).';
    yuv = max_realvar(mut_index).';
    delta1v = (yv - ylv) ./ (yuv - ylv);
    delta2v = (yuv - yv) ./ (yuv - ylv);
    mut_powv = 1.0 ./ (eta_mv + 1.0);
    rv = rand(1, mlen); % r2s ;
    rvlthalf = rv < 0.5 ;
    valv1 = 2.0 .* rv + (1.0 - 2.0 .* rv) .* ...
                        ((1.0 - delta1v) .^ (eta_mv + 1.0));    
    valv2 = 2.0 .* (1.0 - rv) + 2.0 .* (rv - 0.5) .* ... 
                        ((1.0 - delta2v) .^ (eta_mv + 1.0));
    deltaqv = rvlthalf .* ((valv1 .^ mut_powv) - 1.0) + ...
             (~rvlthalf) .* (1.0 - (valv2 .^ mut_powv)); 
    yv = yv + deltaqv .* (yuv - ylv);
    yltyl = yv < ylv ;
    ygtyu = yv > yuv ;
    yv = (yltyl .* ylv) + (yv .* (~yltyl));
    yv = (ygtyu .* yuv) + (yv .* (~ygtyu));        
    % pprint('yv:\n', yv);
    pvec = pvec' ;
    pvec(abs_mut_index.',:) = yv' ;
    pvec = pvec' ;
end
end

