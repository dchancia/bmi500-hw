function out = interpolate_displacement(in)
% function out = interpolate_displacement(in)
%
% This function expects an n x m matrix with n samples of m coordinates.
%
% Gaps in the interior of the matrix are filled with nearest neighbor
% interpolation.
%
% Gaps at the beginning or end are filled with either the first or last
% available value.

out = fillmissing(in,'linear','EndValues','nearest');

end