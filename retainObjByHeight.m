function AI=retainObjByHeight(image,n)

inputImage=(imread(image));
BW = roipoly(inputImage);
% load BWx3
inputImage=imrotate(inputImage,90);
BW=imrotate(BW,90);

h=size(inputImage,1)+1;
%%
for i=1:n
    %%apply sobel filter to getGradient Image
    ENERGY_IMG=getEnergyImage(inputImage); 
    
    ENERGY_IMG(logical(BW))=+(h)*abs(max(max(ENERGY_IMG)));
   
    %find a seam vector from thegiven energy map
    seamVector=findSeam(ENERGY_IMG); 
   
    %Remove seam from original image
    inputImage = removeSeam(inputImage,seamVector);
   
    BW=removeSeam(BW,seamVector);
end

inputImage=imrotate(inputImage,-90);
figure,imshow(uint8(inputImage));