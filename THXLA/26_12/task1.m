load brain_mask
load raw_mri 
class(m)
class(mri)

mri_new = double(mri); 
class(mri_new)
masked_mri = mri_new.*m;

I= masked_mri(:,:,128);
I= squeeze(I);
BW = edge(I);
imshow(BW)