w =(1/9)*[1 1 1 , 1 1 1 , 1 1 1];
 
f = imread('xray1a_change.jpg');

j = imadjust(f,[],[1; 0]);
ggg=im2double(j);
L = imresize(ggg,[512 512]);
L11=L(1:512,1:255);
L12=L(1:512,257:512);
w= fspecial('gaussian',99,16);
[x,y]=size(L);
L2=L.^2; 
L_blurred=imfilter(L,w); 
L2_blurred=imfilter(L2,w); 
L_blurred_2=L_blurred.^2; 
t=(L-L_blurred)./((sqrt(L2_blurred-L_blurred_2))); 
 
smask = fspecial('gaussian', ceil(3*.9), .9);
t = filter2(smask, t, 'same');

claheI = adapthisteq(t,'NumTiles',[40 40]);
claheI = imadjust(claheI); 


imshow(claheI)