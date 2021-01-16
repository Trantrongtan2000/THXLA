I = imread('hc.jpg');
J = imadjust(I,[0 0.2],[0.5 1]);
imshow(I)
figure, imshow(J) 

