im_0 = imread('dataset/billboard/billboard_1.jpg');
mask = min(im_0,[],3)>140;
mask = bwareaopen(mask,400);
mask = repmat(mask.*255,[1,1,3]);
save('dataset/billboard/mask2.mat','mask');
imwrite(mask,'dataset/billboard/mask2.jpg');
figure;imshow(mask);
remain = double(mask ~= 0) .* double(im_0);
figure;imshow(uint8(remain));



