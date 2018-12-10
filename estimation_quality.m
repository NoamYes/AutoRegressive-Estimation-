function [est_qual] = estimation_quality(psd_y1, psd_y2, freq1, freq2)
    
    res = 1000;
    res_vec = floor(linspace(1,length(freq1), res));
    mult_vec = (pi/res)*ones(1,res);
    psd_y1_res = psd_y1(res_vec);
    psd_y2_res = psd_y2(res_vec);
    integrand = abs(10*log10(psd_y1_res./psd_y2_res));
    est_qual = (1/pi)*sum(integrand.*mult_vec.');
end

