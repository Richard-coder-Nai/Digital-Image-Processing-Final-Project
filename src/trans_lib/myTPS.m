function output = myTPS(source,target,target_point)

% target_point = [104,233;121,290;161,416;197,545;217,606;260,192;336,614;422,151;479,628;...
%     588,117;618,641;753,80;754,185;755,362;756,540;758,656;452,392];

[H, W, ~] = size(source);
[HH, WW, ~] =size(target);
y_step = W/4;
x_step = H/4;
source_point = zeros(17,2);
for i=1:5
    source_point(i,1) = 1; source_point(i,2) = floor(1 + (i-1)*y_step);
    source_point(i+11,1) = H; source_point(i+11,2) = floor(1 + (i-1)*y_step);
    if i==5
        source_point(i,2) = W;source_point(i+11,2) = W;
    end
end
for i=1:3
    source_point(2*i+4:2*i+5,1) = floor(x_step*i);
    source_point(2*i+4,2) = 1;source_point(2*i+5,2) = W;
end
source_point(17,1) = floor(H/2);source_point(17,2) = floor(W/2);

output = target;
MatL = zeros(20,20);
for i=1:17
    for j=1:17
        if i==j
            continue
        else
            d_x = target_point(i,1) - target_point(j,1);
            d_y = target_point(i,2) - target_point(j,2);
            r = d_x*d_x +d_y*d_y;
            if r==0
                MatL(i,j)=0;
            else
                MatL(i,j)=r*log(r);
            end
        end
    end
end
P = [ones(17,1) target_point];
MatL(1:17,18:20) = P;
MatL(18:20,1:17) = P';
Y = [source_point' zeros(2,3)];
Y = Y';
mat = inv(MatL) * Y;

for i = 1:HH
    for j = 1:WW
        [xx,yy] = tpsMap(i,j,target_point,mat);
        if xx>=1 && yy>=1 && xx<=H && yy<=W
            output(i,j,:) = source(xx,yy,:);
           
        end
    end
end
% for i=1:3
% output(:,:,i) = double((mask~=0)) .* double(output(:,:,i)) + double((mask == 0)) .* double(target(:,:,i));
% end
% figure;imshow(output);
end

function [x_out, y_out] = tpsMap(i,j,target_point,mat)
U_distance = zeros(1, 20);
        for k =1:17
            d_x = i - target_point(k, 1);
            d_y = j - target_point(k, 2);
            r = d_x*d_x +d_y*d_y;
            if r==0
                U_distance(1,k)=0;
            else
                U_distance(1,k)=r*log(r);
            end
        end
        U_distance(1,18) = 1;
        U_distance(1,19) = i;
        U_distance(1,20) = j;
        oldxy = U_distance*mat;
        x_out = round(oldxy(1,1));y_out= round(oldxy(1,2));
        
end




    
    
    