function data = read_trc(file)
% function data = read_trc(file)
%
% Read a *.trc file into a table
% 
% usage
% supply full path to .trc file
% returns table of marker data

data = readtable(file, "FileType", "Text", "VariableNamesLine", 4, "NumHeaderLines", 6, 'PreserveVariableNames', 1);
data = data(:,1:182);
end

