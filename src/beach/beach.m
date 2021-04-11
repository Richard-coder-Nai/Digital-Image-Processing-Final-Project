function output = beach(input)
% target_point = [539,245;535,291;532,339;529,387;526,435;610,250;599,440;685,259;674,450;...
%     761,266;750,456;841,270;838,318;833,377;830,408;827,464;679,358];
target_img = imread('dataset/beach/beach_1.jpg');
input = rgb2gray(input);
input = repmat(input,[1,1,3]);
% output = myTPS(input,target,target_point);
[h1,w1,c1] = size(input);
xs1 = [1 w1 1 w1]';
ys1 = [1 1 h1 h1]';

[h2,w2,c] = size(target_img);
target_point = [249,538;436,524;275,840;463,823];
tform = fitgeotrans([xs1 ys1],target_point,'affine');
src_registered = imwarp(input,tform,'OutputView',imref2d(size(target_img)));
mask = sum(src_registered,3)~=0;
se = strel('square',3);
mask = imclose(mask,se);
idx = find(mask);
target_img(idx) = src_registered(idx);
target_img(idx+h2*w2) = src_registered(idx+h2*w2);
target_img(idx+2*h2*w2) = src_registered(idx+2*h2*w2);
output = target_img;
end

