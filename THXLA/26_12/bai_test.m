% load mat file containing the original mri
load raw_mri 
% see what's in memory
whos
% create a subplot window
subplot(2,2,1) 
% grab the coronal slice corresponding to y=128 and store it in a new
% variable
coronal_slice = mri(:,128,:);
% NOTE: colon operator denotes "all" elements in the given dimension
% NOTE: semicolon after line suppresses output
% get the size of the slice
size(coronal_slice)
% NOTE: no semicolon as we want to display the current size of the variable
% "coronal_slice"
% remove "singleton" dimension
coronal_slice = squeeze(coronal_slice);

% observe the size of the array after squeezing
size(coronal_slice)
% NOTE: "coronal_slice" is now a 2-dimensional array

% display slice
imagesc(coronal_slice);
% NOTE: intensity of each pixel corresponds to tissue type

% change to a grayscale colormap
colormap(gray)

% add a title to our subplot
title('Coronal Slice')

% display the coronal slice right side up

% create a second panel
subplot(2,2,2)

% display the transposed matrix
imagesc(coronal_slice');
% NOTE: in MATLAB, the prime operator ' denotes matrix transposition

% make the axes Cartesian
axis xy

% insert new title
title('Coronal Slice Right Side Up')


% display the sagittal slice
subplot(2,2,3)

% grab a slice corresponding to the y-z plane
sagittal_slice = mri(128,:,:);
sagittal_slice = squeeze(sagittal_slice);
imagesc(sagittal_slice');
axis xy
title('Sagittal Slice')

% display the axial slice
subplot(2,2,4)

% grab a slice corresponding to the x-y plane
axial_slice = mri(:,:,95);
axial_slice = squeeze(axial_slice);
imagesc(axial_slice');
axis xy
title('Axial Slice')


%%

% load mat file containing our data: mask of the brain
load brain_mask

% display the contents of memory
whos
% NOTE: the mask is stored in a variable called "m"

% get the size of the mask m
size(m)

% get the type of data contained in the "m" variable
class(m)

% get the type of data contained in the "mri" variable
class(mri)

% since the data types don't match up, we must convert one of them to match
% the other if we want to do any processing

% convert "mri" to a floating-point array (as opposed to integer data)
mri_new = double(mri); 

% compare the size of "mri_new" with that of "mri"
whos

% now observe the type of data in "mri_new"
class(mri_new)

% apply the mask to the mri image
masked_mri = mri_new.*m;
% NOTE: .* denotes element-by-element multiplication, which is not the same
% as matrix multiplication

% display three brain slices

% create a new figure window
figure
subplot(2,2,1) 
masked_coronal_slice = masked_mri(:,128,:);
masked_coronal_slice = squeeze(masked_coronal_slice);
imagesc(masked_coronal_slice');
axis xy
colormap(gray)
title('Masked Coronal Slice')

% display the sagittal slice
subplot(2,2,2)
masked_sagittal_slice = masked_mri(128,:,:);
masked_sagittal_slice = squeeze(masked_sagittal_slice);
imagesc(masked_sagittal_slice');
axis xy
colormap(gray)
title('Masked Sagittal Slice')

% display the axial slice
subplot(2,2,3)
masked_axial_slice = masked_mri(:,:,95);
masked_axial_slice = squeeze(masked_axial_slice);
imagesc(masked_axial_slice');
axis xy
colormap(gray)
title('Masked Axial Slice')

%%
