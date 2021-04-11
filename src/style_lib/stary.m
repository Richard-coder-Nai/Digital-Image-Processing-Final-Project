function [output] = stary(input)

input = double(input);
canvas = imread('dataset/style/stary.jfif');
canvas = imresize(canvas,size(input,[1,2]));
canvas = double(canvas);
output = zeros(size(input));
% canvas_hsv = rgb2hsv(canvas);
% canvas_v = canvas_hsv(3);
% input_hsv = rgb2hsv(input);
% input_v = input_hsv(3);
wname = 'db1';
N = 2;

for c = 1:3
    input_v = input(:,:,c);
    canvas_v = canvas(:,:,c);
    [C1,S1] = wavedec2(input_v,N,wname);          
    [C2,S2] = wavedec2(canvas_v,N,wname); 

    A1 = appcoef2(C1,S1,wname,N);            
    A2 = appcoef2(C2,S2,wname,N);

    alpha = 0.80;
    A = alpha * A1 + (1-alpha) * A2;

    C=reshape(A,1,size(A,1)*size(A,2));        

    beta = 0.80;
    for i=N:-1:1                           
        [H1,V1,D1]=detcoef2('all',C1,S1,i);    
        [H2,V2,D2]=detcoef2('all',C2,S2,i);
        H=beta*H1+(1-beta)*H2;                     
        D=beta*D1+(1-beta)*D2;  
        V=beta*V1+(1-beta)*V2;  
        h=reshape(H,1,S1(N+2-i,1)*S1(N+2-i,2));
        v=reshape(V,1,S1(N+2-i,1)*S1(N+2-i,2));
        d=reshape(D,1,S1(N+2-i,1)*S1(N+2-i,2));
        C=[C,h,v,d];
    end

    S=S1;
    output(:,:,c) = waverec2(C,S,wname);
end
% output_hsv = input_hsv;
% output_hsv(3) = output_v;
% output = hsv2rgb(output_hsv);
output = uint8(output);

% figure;imshow(output);
end




