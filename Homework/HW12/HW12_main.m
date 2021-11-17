% BMI500 HW12 - Motion Analysis
% Created by: Daniela Chanci Arrubla
% Date: 11/13/2021

close all; clear; clc;

% Load CSV file as a table
patients = readtable("icd.csv");

% Extract ids and icd
ids = patients.id;
icd = patients.icd;

% Define marker
marker = "L.Finger3.M3";

% Initialize Table
headers = {'record_id','file','icd','markername','max_p','f_max_p','f_sd','rms_power'};
output_table = cell2table(cell(0,length(headers)),'VariableNames', headers);

% Define files folder
folder = 'F:\Users\user\Desktop\EMORY\Classes\Fall_2021\BMI_500\Homework\HW12\deidentified_trc';

% Loop through patients
for i=1:length(ids)
   id = num2str(ids(i));
   filename = dir(fullfile(folder, id, '*.trc')).name;
   path = fullfile(folder, id, filename);
   file = fullfile(id, filename);
   
   % Call tremor analysis function
   outcomes = tremor_analysis(path, marker);
   
   % Create patient cell
   cellPatient = {ids(i),file,icd(i),marker,outcomes(1),outcomes(2),outcomes(3),outcomes(4)};
   
   % Append row to output table
   output_table = [output_table; cellPatient];
end

% Create CSV file
writetable(output_table,'output.csv')
