function AI=reduceWidth(imageName,n)
clc;
inputImage=(imread(imageName));  
figure ,imshow(inputImage);

%%
for i=1:n
%apply sobel filter to get the gradient image
    ENERGY_IMG=getEnergyImage(inputImage); 
  %find seam to be removed
    seamVector=findSeam(ENERGY_IMG);

    %Remove seam from original image  
    inputImage = removeSeam(inputImage,seamVector);
end

figure,imshow(uint8(inputImage));

%%---
end