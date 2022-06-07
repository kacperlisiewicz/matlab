clear; close all; clc;
f = mat2gray(rgb2gray(imread('IMG_0170.jpg')));
I = imcrop(f,[1200 1200 2200 1200]);

Size = size(f);
Binary_f = f;
for i = 1:Size(1)
    for j = 1:Size(2)
        if f(i, j) >= 0.70
            Binary_f(i, j) = 1;
        else
            Binary_f(i, j) = 0;
        end
    end
end
imshow(Binary_f)
d = imdistline;
[centers, radii] = imfindcircles(Binary_f, [150 500], 'Sensitivity', 0.98);
imshow(f)
viscircles(centers, radii,'EdgeColor','b');