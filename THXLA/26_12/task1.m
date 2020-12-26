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