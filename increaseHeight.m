function AI=increaseHeight(imageName,n)
inputImage=double(imread(imageName));
figure,imshow(uint8(inputImage))

%n=70; %n is the number of rows to add
inputImage=imrotate(inputImage,90);
%%
%%apply sobel filter to get Gradient Image
ENERGY_IMG=getEnergyImage(inputImage);
for i=1:n   
     %find a seam vector from the given energy map    
    seamVector=findSeam(ENERGY_IMG);    
 
    %add seam to the original image
    inputImage = addSeam(inputImage,seamVector);   
    
    %also add seam in energy image
    ENERGY_IMG=addSeam(ENERGY_IMG,seamVector,1);
end
inputImage=imrotate(inputImage,-90);
figure,imshow(uint8(round(inputImage)));
end