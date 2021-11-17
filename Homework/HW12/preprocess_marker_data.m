function filtered_data = preprocess_marker_data(data, time, cutoff_frequencies)
% function filtered_data = preprocess_marker_data(data, time, cutoffs)
%
% Filters X, Y, Z marker data based on defined cutoff frequencies
%
% usage
% supply X, Y, Z marker data; time vector; and cutoff frequencies to design 
% and apply Butterworth bandpass filter
% returns filtered X, Y, Z marker data

% Find sampling frequency
ts = mean(diff(time));
fs = 1/ts;

% Design Bandpass Filter
[b, a] = butter(4, cutoff_frequencies/(0.5*fs), 'bandpass');

% Filter X, Y, and Z marker data
filtered_data = filtfilt(b, a, data);
end