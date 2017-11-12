function gradientImage=getEnergyImage(grayImage)
%H=fspecial('sobel');    %Create a soble filter
%xGrad=imfilter(grayImage,H);     %Applying the filter in x direction
%yGrad=imfilter(grayImage,H');
%gradientImage=abs(xGrad)+abs(yGrad);
[gradientImage, Gdir] = imgradient(rgb2gray(grayImage));
for i=1:size(grayImage,3)
    [Ig, Gdir] = imgradient(grayImage(:,:,i));
    gradientImage=gradientImage+Ig;
end
%if(size(gradientImage,3)>1) %if color image
%    gradientImage=mean(gradientImage,3);
%end