close all;
clear all;
clc;

%% Section 4_1

profile on

load 'data.mat';
load 'reflect.mat';

I = zeros(size(R,1),size(R,2),size(R,3));
for i = 1: size(R,1)
    for j = 1: size(R,2)
        for k = 1: size(R,3)
            I(i,j,k) = R(i,j,k)*illum2(1,k);
        end
    end
end

func = [x;y;z];
XYZ = zeros(size(I,1),size(I,2),3);
A = zeros(31,1);

for i = 1: size(I,1)
    for j = 1: size(I,2)
        for l = 1:31
            A(l,1) = I(i,j,l);
        end
        XYZ(i,j,:) = func*A; 
    end
end

matA = [0.640 0.300 0.150; 0.330 0.600 0.060; 0.030 0.100 0.790];
D6 = [0.3127 0.3290 0.3583];
matB = [D6(1)/D6(2); 1; D6(3)/D6(2)];
matK = (matA^(-1))*matB;
diagK = zeros(3,3);
for i = 1:3
    diagK(i,i) = matK(i,1);
end

M = matA*diagK;

trp = zeros(3,1);
rgb = zeros(size(XYZ,1),size(XYZ,2),3);

for i = 1: size(XYZ,1)
    for j = 1: size(XYZ,2)
        for k = 1:3
            trp(k,1) = XYZ(i,j,k);
        end
        rgb(i,j,:) = (M^(-1))*trp;
    end
end

for i = 1: size(rgb,1)
    for j = 1: size(rgb,2)
        for k = 1:size(rgb,3)
            if rgb(i,j,k)>1
               rgb(i,j,k) = 1; 
            end
            if rgb(i,j,k)<0
               rgb(i,j,k) = 0; 
            end
        end
    end
end
rgb = rgb*255;
rgb = uint8(rgb);

figure;
image(rgb+1);
axis('image');
title('Original linear.tif');
graymap = [0:255; 0:255; 0:255]' / 255;
colormap(graymap);

rgb = double(rgb);
y = 255*((rgb ./ 255) .^ (1/2.2));
figure;
y = uint8(y);
image(y + 1);
axis('image');
title('Gamma Corrected Fluorescent');
graymap = [0:255; 0:255; 0:255]' / 255;
colormap(graymap);
print('Sec_4_2' , '-dpng');

profile viewer
p = profile('info')

