function peek(in, varargin)
% function peek(x)
% function peek(x, 10)
% function peek(x, 10, 6)
% function peek(x, 10, 6, tail)
% function peek(x, [], [], tail)
% 
% peek at the contents of a table.

default.Nr = 10;
default.Nc = 6;
default.tail = false;

p = inputParser;
p.addOptional('Nr', default.Nr, @isnumeric);
p.addOptional('Nc', default.Nc, @isnumeric);
p.addOptional('tail', default.tail, @islogical);
p.KeepUnmatched = true;
p.CaseSensitive = false;
p.parse(varargin{:});

Nr = p.Results.Nr;
Nc = p.Results.Nc;
tail = p.Results.tail;

if isempty(Nr)
    Nr = default.Nr;
end
if isempty(Nc)
    Nc = default.Nc;
end

if tail
    in = flip(in);
    dispDat = flip(in(1:min(nrow(in),Nr),1:min(ncol(in),Nc)));
else
    dispDat = in(1:min(nrow(in),Nr),1:min(ncol(in),Nc));
end

[n1,n2] = size(in);

disp(" ")
if isempty(inputname(1))
    n0 = "input";
else
    n0 = inputname(1);
end
disp(string(n0+": "+n1+" x "+n2+" "+class(in)))
disp(" ")
disp(dispDat)

end