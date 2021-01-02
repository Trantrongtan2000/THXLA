% D�ng load ?? load d? li?u file mat g?c
load raw_mri 
% xem b? nh?
whos
% t?o c?a s? Subplot
subplot(2,2,1) 
% t?o l?p c?t coronal slice v?i y=128 v� l?u v�o bi?n m?i, ngo�i ra d?u �:� ?? l?y t?t c? d? li?u trong file
coronal_slice = mri(:,128,:);
% l?y k�ch th??c coronal slice
size(coronal_slice)
% lo?i b? kh�ng gian singleton b?ng l?nh squeezing
coronal_slice = squeeze(coronal_slice);
 
% l?y k�ch th??c coronal slice
size(coronal_slice)
% coronal_slice gi? l� m?ng 2 chi?u
 
% hi?n th? l�t
imagesc(coronal_slice);

% ??i ?nh sang d?ng ?nh x�m
colormap(gray)
 
% th�m ti�u ??
title('Coronal Slice')
 
% Hi?n th? Coronal Slice b�n ph?i
 
% t?o b?ng Subplot th? 2
subplot(2,2,2)
 
% hi?n th? ma tr?n chuy?n v?
imagesc(coronal_slice');
 
% t?o tr?c Cartesian
axis xy
 
% ch�n ti�u ?? m?i
title('Coronal Slice Right Side Up')
 
 
% hi?n th? sagittal slice
subplot(2,2,3)
 
% l?y m?t slice t??ng ?ng m?t ph?ng y-z
sagittal_slice = mri(128,:,:);
sagittal_slice = squeeze(sagittal_slice);
imagesc(sagittal_slice');
axis xy
title('Sagittal Slice')
 
% hi?n th? tr?c c?t
subplot(2,2,4)
 
% l?y m?t slice t??ng ?ng m?t ph?ng x-y

axial_slice = mri(:,:,95);
axial_slice = squeeze(axial_slice);
imagesc(axial_slice');
axis xy
title('Axial Slice')
 
 
%%
 
% D�ng load ?? load d? li?u file brain_mask
load brain_mask
 
% hi?n th? n?i dung b? nh?
whos

% l?y k�ch th??c mask m
size(m)
 
% l?y ki?u d? li?u trong bi?n m
class(m)
% l?y lo?i d? li?n trong bi?n mri
class(mri)
 
% ??i mri sang m?ng double
mri_new = double(mri); 
 
% hi?n th? n?i dung b? nh? 
whos
 
% l?y lo?i d? li?n trong bi?n mri_new
class(mri_new)
 
% x�c nh?n mask cho ?nh mri
masked_mri = mri_new.*m;


% hi?n th? 3 l?p c?t n�o
 
% t?o c?a s? figure m?i
figure
subplot(2,2,1) 
masked_coronal_slice = masked_mri(:,128,:);
masked_coronal_slice = squeeze(masked_coronal_slice);
imagesc(masked_coronal_slice');
axis xy
colormap(gray)
title('Masked Coronal Slice')
 
% hi?n th? l?p sagittal slice
subplot(2,2,2)
masked_sagittal_slice = masked_mri(128,:,:);
masked_sagittal_slice = squeeze(masked_sagittal_slice);
imagesc(masked_sagittal_slice');
axis xy
colormap(gray)
title('Masked Sagittal Slice')
 
% hi?n th? l?p axial slice
subplot(2,2,3)
masked_axial_slice = masked_mri(:,:,95);
masked_axial_slice = squeeze(masked_axial_slice);
imagesc(masked_axial_slice');
axis xy
colormap(gray)
title('Masked Axial Slice')
