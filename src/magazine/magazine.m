function [output] = magazine(input)
target_point = [233,438;269,504;307,572;348,639;393,695;326,380;484,645;424,318;583,590;...
    522,256;683,535;615,196;656,267;698,340;739,414;777,483;503,455];
target = imread('dataset/magazine/magazine_0.jpg');
output = myTPS(input,target,target_point);
end

