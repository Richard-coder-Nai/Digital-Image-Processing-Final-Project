function output = billboard(source,h)
im_0 = imread('dataset/billboard/billboard_0.jpg');
darkc = min(double(im_0),[],3)>10;
darkc = repmat(darkc.*255,[1,1,3]);
mask = load('dataset/billboard/mask2.mat').mask;
% light_bias = double(darkc~=0).*double(im_0);
% light_bias = uint8(light_bias);
% light_bias = double(mask~=0).*double(light_bias);
% light_bias = uint8(light_bias);
light_mask = double(darkc ~= 0).* double(mask ~= 0);
light_mask(mask < 1) = 0.;
% figure;imshow(light_mask);


light_bias = light_mask.* double(im_0);
im_1 = imread('dataset/billboard/billboard_1.jpg');
light_slope = (double(im_1) - double(im_0))./255.;
light_slope = light_mask .* light_slope;
light_slope(light_mask == 0) = 1.;
light_bias(light_mask == 0) = 0.;
% light_bias(:,:,2) =light_bias(:,:,2).*0.8 ;

% source = imread('cat.jpg');
% source = permute(source,[2,1,3]);

target = imread('billboard_0.jpg');
target_point = [104,233;121,290;161,416;197,545;217,606;260,192;336,614;422,151;479,628;...
    588,117;618,641;753,80;754,185;755,362;756,540;758,656;452,392];
im_x = myTPS(source,target,target_point);
% im_x = imread('billboard_zxy.jpg');

color_hsv = rgb2hsv(light_bias);
color_hsv(:,:,1) = h;
color_hsv(:,:,2) = 0.5;
% color_hsv(:,:,3) = color_hsv(:,:,3) * 1.2;
color_bias = hsv2rgb(color_hsv);


% J = double(im_x) - light_slope.*double(light_bias) + light_slope.*double(color_bias);
J = light_slope.*double(im_x) + double(color_bias);

% figure;imshow(mask);
remain = double(mask > 1).* double(J);
% figure;imshow(uint8(remain));




output = double(mask > 1).* double(J) + double(mask == 0).*double(im_0);
output = uint8(output);
% figure;imshow(output);
end