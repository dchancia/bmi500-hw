function names_xyz = append_xyz(names)
names_xyz = reshape([
    names + "_X";
    names + "_Y";
    names + "_Z";
    ],1,3*length(names));
end
