w =(1/9)*[1 1 1 , 1 1 1 , 1 1 1];%avarage mask
 
f = imread('JPCLN018.bmp');

imshow('JPCLN018.bmp');

%Applay Imadjust to image (Stretching gray level)
j = imadjust(f,[],[1; 0]);%//get the negative%%%%%%%%%%%%%%%%5
%%%Convert Image to Double then resize it to 
%512*512 (This reduce the processing time)
ggg=im2double(j);%covert to double
L = imresize(ggg,[512 512]);% Resize image to (512*512)102013(File)
L11=L(1:512,1:255);
L12=L(1:512,257:512);
w= fspecial('gaussian',99,16); %filtro gaussiano de sigma 16
[x,y]=size(L);
%local normalization
L2=L.^2; %imagem original ao quadrado
L_blurred=imfilter(L,w); %imagem original filtrada
L2_blurred=imfilter(L2,w); %imagem original ao quadrado filtrada
L_blurred_2=L_blurred.^2; %imagem original filtrada ao quadrado
t=(L-L_blurred)./((sqrt(L2_blurred-L_blurred_2))); % expressão da local normalization
t=mat2gray(t);
smask = fspecial('gaussian', ceil(3*.9), .9);
t = filter2(smask, t, 'same');
%imtool(t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% FIRST HIST EQULIZATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
claheI = adapthisteq(t,'NumTiles',[40 40]);%,'Distribution' ,'rayleigh');
claheI = imadjust(claheI);
%imtool(claheI);
z1=immultiply(claheI,t);
%imtool(z1);
z11=z1(1:512,1:256);
z12=z1(1:512,257:512);
me1=mean2(z1);%mean of image
st1=std2(z1);%standerd deviation of image
gg11=(z1-me1)*(1/st1);%%normalized image to segment the lung
%imtool(gg11)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% SECOND HIST EQULIZATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
claheI = adapthisteq(t,'NumTiles',[127 20]);%,'Distribution' ,'rayleigh');
claheI = imadjust(claheI);
%imtool(claheI);
z2=immultiply(claheI,t);
%imtool(z2);
z21=z2(1:512,1:256);
z22=z2(1:512,257:512);
me1=mean2(z2);%mean of image
st1=std2(z2);%standerd deviation of image
gg2=(z2-me1)*(1/st1);%%normalized image to segment the lung
%imtool(gg2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% REDUCE LIGHTER SPOTS BORDER%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%
% IM2 = imclearborder(ss)
% imtool(IM2)
%%%%%%%%%%%%%% ACTIVE COUNTOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mask = zeros(size(z11));
mask(55:end-55,75:end-75) = 1;
bw1 = activecontour(z11,mask,500);
mask = zeros(size(z21));
mask(55:end-55,75:end-75) = 1;
bw2 = activecontour(z21,mask,500);
bw=bw1+bw2;
%imtool (bw)
se1 = strel('disk',1);
erodedBW = imerode(bw,se1);
closeBW = imclose(erodedBW,se1);
%%%%Lung Area (Lung Image) %%%%%%%%%%%%%%%%%%%%%%%%%%%% 
f = inline('sum(x(:)) >= 3');
lut = makelut(f,3);
BW2 = applylut(bw,lut);
L2 = bwlabel(BW2);
stats2 = regionprops(L2,'all');
%%% Serech for lung area larger than 20000 pixels
idx2 = find([stats2.Area] > 20000);
BW2 = ismember(L2,idx2);
%figure, imshow(BW2)%%% lung without nod
small_lung_R = imfill(BW2,'holes');
%imtool(small_lung_R)
% sob = edge(small_lung_R, 'canny', (graythresh(z21) * .1));
% BWoutline = bwperim(sob);
%%figure, imshow(BWoutline)
%I2 = imfill(small_lung_R,'holes');
I2=small_lung_R;
se = strel('line',11,90);
bw2 = imdilate(I2,se);
sob = edge(bw2, 'canny', (graythresh(z21) * .1));
BWoutline = bwperim(sob);
 
figure, imshow(I2);
Segout1 = L11; 
Segout1(BWoutline) =0; 
imtool(Segout1)
