function outcomes = tremor_analysis(path, markername)
% outcomes = tremor_analysis(path, markername)
%
% Obtain outcomes of marker data
%
% usage
% supply path to data and marker name to obtain the required outputs
% returns outputs - max_p, f_max_p, f_sd, rms_power

% Read
trc = rename_trc(read_trc(path));
raw_data = trc{:,startsWith(names(trc), markername)};
filtered_data = preprocess_marker_data(raw_data, trc.Time, [2 45]);

% Time and PC1
time_s = trc.Time;
pc1_mm = pc1(filtered_data);

TT = timetable(seconds(time_s), pc1_mm);
TT.Properties.VariableNames = markername;
TT.Properties.VariableUnits = ["mm"];

[p, f, ~] = pspectrum(TT, 'spectrogram', 'MinThreshold', -50, ...
    'FrequencyResolution', 0.5, 'FrequencyLimits', [0 20]);

% Visualization 2D
% figure;
% hold on
% for i=1:size(p,2)
%     plot(f, p(:,i))
% end

%%% Max power in any window (mm2/Hz)
max_p = max(p, [],'all');

%%% Frequency at overall max power (Hz)
% Find index where max_p is located
[idx_max_f,idx_max_p] = find(p == max_p);
% Identify frequency at the index above
f_max_p = f(idx_max_f);

%%% Variability in peak frequency, Hz
% Find index of maximum value of each column
[~,idx_f] = max(p);
% Calculate std for frequencies at indexes above
f_sd = std(f([idx_f]));

%%% Average RMS power (mm) within +/- 0.5 Hz of frequency at overall max
%%% power
% Find indexes where frequencies fall into the interval
idx_f_interval = find(f>(f_max_p-0.5) & f<(f_max_p+0.5));
% Calculate RMS
rms_power = rms(p([idx_f_interval],idx_max_p));

% Outcomes
outcomes = [max_p, f_max_p, f_sd, rms_power];
end