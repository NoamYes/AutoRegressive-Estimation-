clear all; close all; clc;

%% Section 1
sys = zpk([],[-0.6+0.6i , -0.6-0.6i , 0.68+0.62i , 0.68-0.62i], 1);
figure(1);
pzmap(sys)
title('zeros - poles map of original transfer function - none zeros');
hold on;
[b,a] = zp2tf([],[-0.6+0.6i , -0.6-0.6i , 0.68+0.62i , 0.68-0.62i], 1);

H = tf(b,a, 0.1, 'variable', 'z^-1');
figure(2)
[mag,~,wout] = bode(H);
plot(wout, mag(:));
title('theroteical Bode plot (Amp and Phase) of h1 -none zeros')

noise = randn(1,10000);
y = filter(b,a,noise);
psd = 20*log(abs(fft(y)).^2);
[~, freq] = freqz(b,a,length(psd));
figure(3)
plot((freq),psd);
hold on;
title('Power Spectrum Destiny of y');
xlabel('Frequency[Rad/Sec]');
ylabel('Magnitude[dB]');

%% Section 2

p = 4;
[freq_hat,psd_hat, sys_hat] = psd_ar(p,y, b);
figure(1)
pzmap(sys_hat);
figure(3)
plot(freq_hat,psd_hat);
title('Power Spectrum Destiny of y');
xlabel('Frequency');
ylabel('Magnitude');

% Estimation Quality

est_qual1 = estimation_quality(psd, psd_hat, freq, freq_hat);

%% Section 3

sys1 = zpk(0.9,[-0.6+0.6i , -0.6-0.6i , 0.68+0.62i , 0.68-0.62i], 1);
figure(4)
pzmap(sys1)
title('Zeros- Poles map of transfer with zero at z=0.9');
[b2,a2] = zp2tf(0.9,[-0.6+0.6i , -0.6-0.6i , 0.68+0.62i , 0.68-0.62i], 1);

H2 = tf(b,a, 0.1, 'variable', 'z^-1');

figure(5)
[mag2,~,wout2] = bode(H2);
plot(wout2, mag2(:));
title('theroteical Bode plot (Amp and Phase) of h2 - zero at 0.9');

noise = randn(1,10000);
y2 = filter(b2,a2,noise);

%% Section 4

p = 4;
[freq, psd, sys] = psd_ar(p, y2, b2);
figure(6)




