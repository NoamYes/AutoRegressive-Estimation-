clear all; close all; clc;

%% Section 1
sys = zpk([],[-0.6+0.6i , -0.6-0.6i , 0.68+0.62i , 0.68-0.62i], 1,[], 'Variable', 'z^-1');
figure(1);
pzmap(sys)
title('zeros - poles map of original transfer function - none zeros');
hold on;


H = tf(sys);
a1 = cell2mat(H.Denominator);
b1 = cell2mat(H.Numerator);
[psd1, freq] = freqz(b1,a1,1e3);
figure(2)
plot((freq),db(psd1));
hold on;

%% Section 2

p = 4;
noise = randn(1,10000);
y1 = filter(b1,a1,noise);
[freq_hat,psd_hat, sys_hat] = psd_ar(p,y1, b1);
figure(1)
pzmap(sys_hat);
figure(2)
plot(freq_hat,db(psd_hat));
title('Power Spectrum Destiny of therotical y1 vs estimated y1');
xlabel('Frequency');
ylabel('Magnitude[dB]');

% Estimation Quality

est_qual1 = estimation_quality(psd1, psd_hat, freq, freq_hat);

%% Section 3

sys2 = zpk(0.9,[-0.6+0.6i , -0.6-0.6i , 0.68+0.62i , 0.68-0.62i], 1);
figure(3)
pzmap(sys2)
title('Zeros- Poles map of transfer with zero at z=0.9');

H2 = tf(sys2);
a2 = cell2mat(H.Denominator);
b2 = cell2mat(H.Numerator);
[psd2, freq] = freqz(b2,a2,1e3);


%% Section 4





