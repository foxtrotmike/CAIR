function gradientImage=getEnergyImage(grayImage)
%H=fspecial('sobel');    %Create a soble filter
%xGrad=imfilter(grayImage,H);     %Applying the filter in x direction
%yGrad=imfilter(grayImage,H');
%gradientImage=abs(xGrad)+abs(yGrad);
[gradientImage, Gdir] = imgradient(rgb2gray(grayImage));
gradientImage = gradientImage./max(max(gradientImage));
% for i=1:size(grayImage,3)
%     [Ig, Gdir] = imgradient(grayImage(:,:,i));
%     Ig = Ig./max(max(Ig));
%     gradientImage=gradientImage+Ig;
% end
% gradientImage = gradientImage./max(max(gradientImage));
gradientImage = gradientImage.*2;
gradientImage = gradientImage./norm(gradientImage);
%if(size(gradientImage,3)>1) %if color image
%    gradientImage=mean(gradientImage,3);
%end