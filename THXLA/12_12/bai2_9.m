graindata=regionprops(labeled,'basic')
graindata(51).Area
graindata(51).BoundingBox, graindata(51).Centroid
allgrains=[graindata.Area];
whos allgrains