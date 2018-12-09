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
frame = y(1000:1511);
[a_hat,e,k] = levinson(autocorr(frame),p);
sys_hat = zpk([],a_hat, 1);
y_hat = filter(b,a_hat,noise);
psd_hat = 20*log(abs(fft(y_hat)).^2);
[~, freq_hat] = freqz(b,a_hat,length(psd_hat));
figure(2)
plot(freq_hat,psd_hat);
title('Power Spectrum Destiny of y');
xlabel('Frequency');
ylabel('Magnitude');

