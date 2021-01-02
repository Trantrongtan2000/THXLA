w =(1/9)*[1 1 1 , 1 1 1 , 1 1 1];%avarage mask
 
f = imread('JPCLN018.bmp');


j = imadjust(f,[],[1; 0]);

%Dùng imadjust ?? kéo dài m?c xám
j = imadjust(f,[],[1; 0]);% Chuy?n ??i hình ?nh thành Double sau ?ó thay ??i kích th??c nó thành 512 * 512 (?i?u này làm gi?m th?i gian x? lý)
ggg=im2double(j);%??i sang double
L = imresize(ggg,[512 512]);% Thay ??i kích th??c hình ?nh thành (512 * 512)
L11=L(1:512,1:255);
L12=L(1:512,257:512);
w= fspecial('gaussian',99,16); %Dùng b? l?c gaussian
[x,y]=size(L);
L2=L.^2; % bình ph??ng ?nh g?c 
L_blurred=imfilter(L,w); %l?c ?nh g?c
L2_blurred=imfilter(L2,w); %l?c ?nh ?ã bình ph??ng
L_blurred_2=L_blurred.^2; %l?c ?nh c?a ph?n l?c ?nh g?c ?ã bình ph??ng 
t=(L-L_blurred)./((sqrt(L2_blurred-L_blurred_2)));
t=mat2gray(t);
smask = fspecial('gaussian', ceil(3*.9), .9);
t = filter2(smask, t, 'same');

claheI = adapthisteq(t,'NumTiles',[40 40]);%,'Distribution' ,'rayleigh');
claheI = imadjust(claheI);



z1=immultiply(claheI,t);

z11=z1(1:512,1:256);
z12=z1(1:512,257:512);
me1=mean2(z1);%mean of image
st1=std2(z1);%standerd deviation of image
gg11=(z1-me1)*(1/st1);%%normalized image to segment the lung




claheI = adapthisteq(t,'NumTiles',[127 20]);%,'Distribution' ,'rayleigh');
claheI = imadjust(claheI);


z2=immultiply(claheI,t);


z21=z2(1:512,1:256);
z22=z2(1:512,257:512);
me1=mean2(z2);%mean of image
st1=std2(z2);%standerd deviation of image
gg2=(z2-me1)*(1/st1);%%normalized image to segment the lung


f = inline('sum(x(:)) >= 3'); %t?o thu?t toán
lut = makelut(f,3); %l?p b?ng tra c?u
BW2 = applylut(bw,lut); %biên d?ch ?nh b?ng b?ng tra c?u
L2 = bwlabel(BW2); %g?n nhãn cho ?nh
stats2 = regionprops(L2,'all');
%%% Serech for lung area larger than 20000 pixels
idx2 = find([stats2.Area] > 20000);
BW2 = ismember(L2,idx2);

%figure, imshow(BW2)%%% lung without nod
small_lung_R = imfill(BW2,'holes');
%imshow(small_lung_R)

 %sob = edge(small_lung_R, 'canny', (graythresh(z21) * .1));
 %BWoutline = bwperim(sob);
%figure, imshow(BWoutline)
%I2 = imfill(small_lung_R,'holes');

I2=small_lung_R;
se = strel('line',11,90);
bw2 = imdilate(I2,se);
sob = edge(bw2, 'canny', (graythresh(z21) * .1));
BWoutline = bwperim(sob);
 

Segout1 = L11; 
Segout1(BWoutline) =0; 
imshow(Segout1)
