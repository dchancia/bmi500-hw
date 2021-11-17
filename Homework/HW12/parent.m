function out = parent(in)
% function out = parent(in)

[parent, stem, ext] = fileparts(in);

out = string(parent);
end
