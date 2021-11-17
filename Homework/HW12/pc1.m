function primary_component = pc1(filtered_data)
% primary_component = pc1(filtered_data)
%
% Obtain primary component of filtered marker data
%
% usage
% supply filtered data and apply SVD to obtain the principal component
% returns primary component filtered marker data

% Apply SVD to filtered marker data
[~,~,V] = svd(filtered_data);

% Projection into the principal axis
primary_component = filtered_data*V(:,1);
end