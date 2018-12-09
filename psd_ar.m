function [freq, psd, sys] = psd_ar(p, y, b)

    frame = y(1000:1511);
    [a_hat,e,k] = levinson(autocorr(frame),p);
    [z,p,k] = tf2zp(b,a_hat);
    sys = zpk(z,p, 1);
    noise = randn(1,10000);
    y_hat = filter(b,a_hat,noise);
    psd = 20*log(abs(fft(y_hat)).^2);
    [~, freq] = freqz(b,a_hat,length(psd));

    % estimation quality
    
    


end

