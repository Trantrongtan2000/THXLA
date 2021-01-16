i=imread('redblood.jpg');
bg=imopen(i,strel('disk',15));

i2=imsubtract(i,bg);

i3= imadjust(i2, stretchlim(i2), [0 1]);
imshow(i2)
lv=graythresh(i3);
bw=im2bw(i3,lv);

[labeled,numObjects]=bwlabel(bw,4);
numObjects


