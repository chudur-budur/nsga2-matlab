function [pvec] = real_mutate(pvec, pmut_real, eta_m, ...
                                min_realvar, max_realvar)
%   This code applies polynomical mutation over pvec.

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

