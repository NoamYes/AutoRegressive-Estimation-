function [freq, amp_hat, sys] = psd_ar(p, y, b, N)

    frame = y(1000:1000+N);
    [a_hat,e,k] = levinson(autocorr(frame),p);
    a_hat(e<0) = [];
    [z,p,k] = tf2zp(b,a_hat);
    sys = zpk(z,p, 1);
    noise = randn(1,10000);
    y_hat = filter(b,a_hat,noise);
    [amp_hat, freq] = freqz(b,a_hat,1e3);

    
    


end

