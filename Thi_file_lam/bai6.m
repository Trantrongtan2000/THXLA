w1=fspecial('unsharp',0.2); 
w2=1/9*ones(3,3);  
P=imread('xray1a_change.jpg');
figure(1),imshow(P),title('Raw Image') 

P=histeq(P);
figure(2),imshow(P) 

P=ordfilt2(P,1,ones(3,3),'symmetric');  
figure(3),imshow(P)

P=imcomplement(P);    
figure(4),imshow(P)

P=imfilter(P,w1,'replicate');  
figure(5),imshow(P)

P=histeq(P);                           
figure(6),imshow(P)

P=imfilter(P,w2,'replicate');               
figure(7),imshow(P)

P=ordfilt2(P,9,ones(3,3),'symmetric');   
figure(8),imshow(P)

[r, c] = size(P);
P=adapthisteq(P,'NumTiles',[round(r/10) round(c/10)],'ClipLimit',0.03);
figure(9),imshow(P),title('Enhanced Image') 


