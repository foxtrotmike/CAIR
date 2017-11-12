function AI=reduceHeight(imageName,n)
inputImage=(imread(imageName)); 
figure,imshow(inputImage,[])

inputImage=imrotate(inputImage,90);

%%
for i=1:n
    %%apply sobel filter to get Gradient Image
    ENERGY_IMG=getEnergyImage(inputImage); 

    %find a seam vector from the given energy map
    seamVector=findSeam(ENERGY_IMG);

    %Remove seam from original image  
    inputImage = removeSeam(inputImage,seamVector);
end

inputImage=imrotate(inputImage,-90);
figure,imshow(uint8(inputImage));
%%---
end