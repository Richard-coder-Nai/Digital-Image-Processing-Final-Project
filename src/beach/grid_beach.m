I = ones(692,440);
[H,W] = size(I);
y_step = W/4;
x_step = H/4;
for i = 1:4
    I(i*x_step:i*x_step+4,:) = 0;
    I(:,i*y_step:i*y_step+4) = 0;
end
imshow(I);
imwrite(I,'dataset/beach/grid_beach.jpg')