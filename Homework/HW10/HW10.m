% BMI HW10 - Neural Time-Series Analysis Lab 
% Created by: Daniela Chanci Arrubla
% Date: 11/07/2021

clear; clc; close;

%% PART A

% Create and plot four sine waves
fs = 1000;
ts = 1/fs;
t = 0:ts:1-ts;
x1 = 5*sin(2*pi*5*(t) + 10*pi/180);
x2 = 15*sin(2*pi*20*(t) + 20*pi/180);
x3 = 10*sin(2*pi*10*(t)+ 180*pi/180);
x4 = 5*sin(2*pi*60*(t) + 90*pi/180);
x = [x1; x2; x3; x4];

% Plot sine waves
figure;
for i = 1:4
    subplot(4,1,i)
    plot(t, x(i,:), 'k')
    axis([0 1 -15 15]);
    xlabel("Time (s)");
    ylabel("Amplitude");
end
sgtitle('Individual Sine Waves', 'FontSize', 13) 

% Sum sine waves
figure;
xsum = x1 + x2 + x3 + x4;
plot(t, xsum, 'k');
title("Sum of sine waves", 'FontSize', 13)
xlabel("Time (s)");
ylabel("Amplitude");

% Fourier Analysis
fxsum = fft(xsum);
n = length(xsum);
P2 = abs(fxsum/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(n/2))/n;

% Plot Region of interest
figure;
plot(f, P1, 'k');
title("Fourier Analysis", 'FontSize', 13)
xlabel("Frequency (Hz)");
ylabel("Power");
xlim([0 80]);

%%
% 
%  Initially, the sine waves were generated with frequencies: 5, 10, 20, 
%  and 60 Hz. These are the same frequencies that can be observed in the
%  Fourier Analysis, indicating that the code is correct.
%  
% 


%% PART B

% Add small amount of random noise
figure;
subplot(2,1,1);
xnoise1 = xsum + 3*rand(size(t));
plot(t, xnoise1, 'k');
title("Small amount of random noise added", 'FontSize', 13)
xlabel("Time (s)");
ylabel("Amplitude");

% Add large amount of random noise
subplot(2,1,2);
xnoise2 = xsum + 40*rand(size(t));
plot(t, xnoise2, 'k');
title("Large amount of random noise added", 'FontSize', 13)
xlabel("Time (s)");
ylabel("Amplitude");

% Fourier Analysis small amount of noise added
fxnoise1 = fft(xnoise1);
P2 = abs(fxnoise1/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1);
figure;
subplot(1,2,1)
plot(f, P1, 'k');
title("Fourier Analysis (small noise)", 'FontSize', 12)
xlabel("Frequency (Hz)");
ylabel("Power");
xlim([0 80]);

% Fourier Analysis small amount of noise added
fxnoise2 = fft(xnoise2);
P2 = abs(fxnoise2/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(1,2,2)
plot(f, P1, 'k');
title("Fourier Analysis (large noise)", 'FontSize', 12)
xlabel("Frequency (Hz)");
ylabel("Power");
xlim([0 80]);

%%
% 
%  After the addition of the small and large amount of noise to the signal,
%  it is posible to observe small frequency components along the x-axis in
%  the Fourier analysis plot. For the small amount of noise, these new
%  components are almost zero.
%  The sine waves with noise are easier to identify in the frequency domain 
%  because the corresponding frequency components (5, 10, 20, and 60Hz) are
%  still much more visible than the noise frequencies.
%
%  
% 

%% PART C

% Create nonstationary signal
tnonst = 0:ts:4-ts;
xnonst = [t.*x1 t.*x2 t.*x3 t.*x4];
n = length(xnonst);

% Plot nonstationary signal
figure;
plot(tnonst, xnonst, 'k')
xlabel("Time (s)");
ylabel("Amplitude");
title("Time-dependent amplitude and frequency", 'FontSize', 13)

% Fourier Analysis
fxnonst = fft(xnonst);
P2 = abs(fxnonst/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(n/2))/n;

% Plot Fourier Analysis
figure;
plot(f, P1, 'k');
title("Fourier Analysis", 'FontSize', 13)
xlabel("Frequency (Hz)");
ylabel("Power");
xlim([0 80]);

%% PART D

% Short-Term Fourier Transform window 1
figure;
stft(xnonst,fs,'Window',kaiser(50,3))

% Short-Term Fourier Transform window 2
figure;
stft(xnonst,fs,'Window',kaiser(128,3))

% Short-Term Fourier Transform window 3
figure;
stft(xnonst,fs,'Window',kaiser(200,3))

% Short-Term Fourier Transform window 4
figure;
stft(xnonst,fs,'Window',kaiser(220,3))

% Short-Term Fourier Transform window 5
figure;
stft(xnonst,fs,'Window',kaiser(256,3))

%%
% 
%  Comparison: After comparing the STFT with different window sizes, it is
%  possible to conclude that with small windows it is easier to identify
%  the time components, while for the frequency components the resolution
%  is low. The opposite occurs for larger windows. It is easier to identify
%  the frequency components, but the resolution for the time components is
%  low.
%  
% 
%% PART E

% Load dataset
load dataset

% Visualize dataset
figure;
plot(eeg, 'k');
xlabel("Time");
ylabel("Voltage");
title("EEG Data", 'FontSize', 13)

% Fourier Analysis
n = length(eeg);
feeg = fft(eeg);
P2 = abs(feeg/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(n/2))/n;

% Plot Fourier Analysis
figure;
plot(f, P1, 'k');
title("Fourier Analysis EEG", 'FontSize', 13)
xlabel("Frequency (Hz)");
ylabel("Power");
xlim([0 80]);

% Short-Term Fourier Transform window 1
figure;
stft(eeg,fs,'Window',kaiser(50,3))

% Short-Term Fourier Transform window 2
figure;
stft(eeg,fs,'Window',kaiser(128,3))

% Short-Term Fourier Transform window 3
figure;
stft(eeg,fs,'Window',kaiser(200,3))

% Short-Term Fourier Transform window 4
figure;
stft(eeg,fs,'Window',kaiser(220,3))

% Short-Term Fourier Transform window 5
figure;
stft(eeg,fs,'Window',kaiser(256,3))

%%
% 
%  It is difficult to identify how many trials are included in this
%  dataset. However, after analyzing the STFT plots with small window size,
%  there are approximately 4 trials.
% 
% 
