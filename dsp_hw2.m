%% Section 1
sys = zpk([],[-0.6+0.6i , -0.6-0.6i , 0.68+0.62i , 0.68-0.62i], 1);
figure(1);
pzmap(sys)
[b,a] = zp2tf([],[-0.6+0.6i , -0.6-0.6i , 0.68+0.62i , 0.68-0.62i], 1);
noise = randn(1,10000);
y = filter(b,a,noise);
psd = 20*log(abs(fft(y)).^2);
figure(2)
plot(psd);
hold on;
title('Power Spectrum Destiny of y');
xlabel('Frequency[Rad/Sec]');
ylabel('Magnitude[dB]');

%% Section 2
p = 4;
frame = y(1000:1511);
[a_hat,e,k] = levinson(autocorr(frame),p);
sys_hat = zpk([],a_hat, 1);
y_hat = filter(b,a,noise);
psd_hat = 20*log(abs(fft(y_hat)).^2);
plot(psd_hat);
title('Power Spectrum Destiny of y');
xlabel('Frequency');
ylabel('Magnitude');