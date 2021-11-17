function str = names(tbl)

nms = string(tbl.Properties.VariableNames);

if nargout
    str = nms;
else
    disp(nms')
end

end