function output = painting(input)
[H, W, C] = size(input);
input_gray = double(rgb2gray(input));
[gx,gy] = imgradientxy(input_gray,'sobel');
gradient = sqrt(gx.^2 + gy.^2);
gradient_gray = im2uint8(mat2gray(gradient));
% figure;imshow(gradient_gray);
output_gray = double(input_gray);
thresh = 165;


down_sampling = 2.*(120.-double(gradient_gray));
down_sampling(input_gray<80) = input_gray(input_gray<80);
output_gray(gradient_gray > 255 - thresh) = 1./1.5*output_gray(gradient_gray > 255 - thresh);
output_gray(gradient_gray <= 255 - thresh) = down_sampling(gradient_gray <= 255 - thresh);

w=fspecial('average',[5 5]);

output_gray = imfilter(output_gray,w);

output = zeros(size(input));
for c = 1:3
    output(:,:,c) = output_gray;
end
output_hsv = rgb2hsv(output);
input_hsv = rgb2hsv(input);
output_hsv(:,:,1) = input_hsv(:,:,1);
output_hsv(:,:,2) = input_hsv(:,:,2);

output = uint8(hsv2rgb(output_hsv));
% figure;imshow(uint8(output));
end




