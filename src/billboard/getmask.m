white_pic = imread('billboard_1.jpg');
black_pic = imread('billboard_0.jpg');
mask = ones(size(white_pic));
mask(abs(white_pic-black_pic) <= 40) = 0;
mask = mean(mask,3);
% mask(mask~=0) = 1;
mask = bwareaopen(mask,400);
se = strel('square',10);
mask = imopen(mask,se);
imshow(mask);


imwrite(mask,'dataset/billboard/mask.jpg');
