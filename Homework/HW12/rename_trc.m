function trc = rename_trc(trc)
nms = names(trc);
trc.Properties.VariableNames = [nms(1:2) append_xyz(extract_marker_names(names(trc)))];
end

