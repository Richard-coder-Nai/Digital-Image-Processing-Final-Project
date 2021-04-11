input = imread('dataset/input/cat.jpg');
%%Styles
canvas_img = canvas(input);%canvas style
figure;imshow(canvas_img);title('Canvas Style');
stary_img = stary(input);%stary night style
figure;imshow(stary_img);title('Stary Night Style');
[sketch_img,color_pencil_img] = sketch(input);%sketch style and color pencil style
figure;imshow(sketch_img);title('Sketch Style');
figure;imshow(color_pencil_img);title('Colot Pencil Style');

%%Backgrounds
billboard_img = billboard(input,0.2);%billboard background, the second parameter means the hue value of light
figure;imshow(billboard_img);title('Billboard Background');
magazine_img = magazine(input);%magazine background
figure;imshow(magazine_img);title('Magazine Background');
beach_img = beach(input);%beach background
figure;imshow(beach_img);title('Beach Background');