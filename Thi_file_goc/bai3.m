I=imread('hc.jpg');
BW1 = edge(I,'sobel');
BW2 = edge(I,'canny');
imshow(BW1)
figure, imshow(BW2)

S = qtdecomp(I,0.2)