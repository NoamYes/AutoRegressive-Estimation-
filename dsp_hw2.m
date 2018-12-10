clear all; close all; clc;

%% Section 1
sys = zpk([],[-0.6+0.6i , -0.6-0.6i , 0.68+0.62i , 0.68-0.62i], 1,[], 'Variable', 'z^-1');
figure(1);
pzmap(sys)
title('zeros - poles map of original transfer function - none zeros');
hold on;
[b,a] = zp2tf([],[-0.6+0.6i , -0.6-0.6i , 0.68+0.62i , 0.68-0.62i], 1);

H = tf(b,a, 0.1, 'variable', 'z^-1');

noise = randn(1,10000);
y = filter(b,a,noise);
psd = fft(xcorr(y));
[psd1, freq] = freqz(b,a,length(psd));
figure(2)
plot((freq),db(psd1));
hold on;

%% Section 2

p = 4;
[freq_hat,psd_hat, sys_hat] = psd_ar(p,y, b);
figure(1)
pzmap(sys_hat);
figure(2)
plot(freq_hat,db(psd1));
title('Power Spectrum Destiny of therotical y1 vs estimated y1');
xlabel('Frequency');
ylabel('Magnitude[dB]');

% Estimation Quality

est_qual1 = estimation_quality(psd1, psd_hat, freq, freq_hat);

%% Section 3

sys1 = zpk(0.9,[-0.6+0.6i , -0.6-0.6i , 0.68+0.62i , 0.68-0.62i], 1);
figure(3)
pzmap(sys1)
title('Zeros- Poles map of transfer with zero at z=0.9');
[b2,a2] = zp2tf(0.9,[-0.6+0.6i , -0.6-0.6i , 0.68+0.62i , 0.68-0.62i], 1);

H2 = tf(b,a, 0.1, 'variable', 'z^-1');

noise = randn(1,10000);
y2 = filter(b2,a2,noise);

%% Section 4





