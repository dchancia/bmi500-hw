% Created by: Daniela Chanci Arrubla - 09/11/2021
%
% MATLAB code to clean and analyze data obtained from Old Faithful geyser
% in Yellowstone National Park.
%
% Data description: Waiting time between eruptions and duration of the
% eruption.

clear;clc;

%% Data Cleaning
dataGeyser = readtable("geyser.csv", "Format", "auto"); % Read CSV file
dataGeyser.eruptions = strrep(strrep(dataGeyser.eruptions, "l", "1"), "O", "0"); % Fix 
% typos. Replace l with 1 and O with 0 in the eruptions column
dataGeyser.waiting = strrep(strrep(dataGeyser.waiting, "l", "1"), "O", "0"); % Fix 
% typos. Replace l with 1 and O with 0 in the waiting column 
dataGeyser = str2double(table2array(dataGeyser)); % Convert table to matrix
dataGeyser = rmmissing(dataGeyser); % Remove NaN values
dataGeyser = dataGeyser(dataGeyser(:,1)>0, :); % Remove negative values
dataGeyser_clean = rmoutliers(dataGeyser); % Remove outliers

%% Plotting

% Bad Plot
figure();
plot(dataGeyser_clean(:,1), dataGeyser_clean(:,2), "y+")
xlabel("Eruption")
ylabel("Waiting")
axis([0 6 0 100])

% Good Plot
figure();
plot(dataGeyser_clean(:,1), dataGeyser_clean(:,2), "k.", "MarkerSize", 12)
xlabel("Eruption Duration (min)", "FontSize", 12)
ylabel("Waiting Time Between Eruptions (min)", "FontSize", 12)
title("Old Faithful Geyser", "FontSize", 14)