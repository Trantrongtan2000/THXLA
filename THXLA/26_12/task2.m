load raw_mri
I= mri(:,:,95);
I= squeeze(I);
colormap(gray)
J = histeq(I);
figure, imshow(J)
imhist(I,64)
figure; imhist(J,64)
