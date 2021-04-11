function [output1,output2] = sketch(input)
input_yuv = rgb2ycbcr(input);
input_gray = input_yuv(:,:,1);
input_gray = double(input_gray);
input_gray = medfilt2(input_gray,[3,3]);
[gx,gy] = imgradientxy(input_gray,'sobel');
gradient = sqrt(gx.^2 + gy.^2);
[H,W] = size(input_gray);
% gradient =  [abs(input_gray(:,1:(end-1)) - input_gray(:,2:end)),zeros(H,1)]+[abs(input_gray(1:(end-1),:) - input_gray(2:end,:));zeros(1,W)];

kernel_size =8;
kernel0 = zeros(kernel_size*2 + 1);
kernel0(kernel_size + 1,:) = 1;

dirs = zeros(H,W,8);

for n = 1:8
    ker = imrotate(kernel0, (n-1)*180/8, 'bilinear', 'crop');
    dirs(:, :, n) = conv2(gradient, ker, 'same');
end

[~,index] = max(dirs,[],3);
C = zeros(H,W,8);

for n = 1:8
    C(:,:,n) = gradient .* (index==n);
end

Sn = zeros(H,W,8);

for n = 1:8
    ker = imrotate(kernel0, (n-1)*180/8, 'bilinear', 'crop');
    Sn(:,:,n) = conv2(C(:,:,n),ker,'same');
end

S = sum(Sn,3);
S = (S - min(S(:)))./(max(S(:))-min(S(:)));

stroke = 1 - S;
stroke = stroke.^4;
stroke = uint8(stroke.*255);
output1 = stroke;
% figure;imshow(stroke);

i = 0.:1:255.;
p1 = (1/9) * exp(-(255 - i)/9);
p2 = zeros(1,256);
p2(105: 225) = 1/(225-105);
p3 = (1/sqrt(2*pi*11)) * exp(-(i-90).*(i-90)/(2.0*11*11));

w1 = 52; w2 = 37; w3 = 11;
p = p1*w1 + p2*w2 + p3*w3;

cdf_goal = cumsum(p);
cdf_goal = cdf_goal/cdf_goal(255);

[hist_ori,cdf_ori] = imhist(uint8(input_gray));
cdf_ori = cumsum(hist_ori);
cdf_ori = cdf_ori/cdf_ori(255);

I_tone = zeros(size(input_gray));
for m = 1:H
    for n = 1:W
        v = cdf_ori(1+uint8(input_gray(m,n)));
        [~,color_goal] = min(abs(cdf_goal - v));
        I_tone(m,n) = color_goal -1;
    end
end





output_y = double(I_tone)/255 .* double(stroke);
output_yuv = input_yuv;
output_yuv(:,:,1) = output_y;
output2 = ycbcr2rgb(output_yuv);
output2 = uint8(output2);
% figure;imshow(output2);

end

