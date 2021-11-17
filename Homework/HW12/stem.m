function out = stem(in)
% function out = stem(in)

[parent, stem, ext] = fileparts(in);

out = string(stem);
end
