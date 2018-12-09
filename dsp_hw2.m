clear all; close all; clc;

%% Section 1
sys = zpk([],[-0.6+0.6i , -0.6-0.6i , 0.68+0.62i , 0.68-0.62i], 1);
figure(1);
pzmap(sys)
[b,a] = zp2tf([],[-0.6+0.6i , -0.6-0.6i , 0.68+0.62i , 0.68-0.62i], 1);
noise = randn(1,10000);
y = filter(b,a,noise);
psd = 20*log(abs(fft(y)).^2);
[~, freq] = freqz(b,a,length(psd));
figure(2)
plot(freq,psd);
hold on;
title('Power Spectrum Destiny of y');
xlabel('Frequency[Rad/Sec]');
ylabel('Magnitude[dB]');

%% Section 2

p = 4;
[freq_hat,psd_hat] = psd_ar(p,y, b);
figure(2)
plot(freq_hat,psd_hat);
title('Power Spectrum Destiny of y');
xlabel('Frequency');
ylabel('Magnitude');

% Estimation Quality

est_qual1 = estimation_quality(psd, psd_hat, freq, freq_hat);

%% Section 3

H = tf(b,a, 0.1, 'variable', 'z^-1');
figure()
bode(H);
