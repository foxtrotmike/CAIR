function inputImage = Englarge(inputImage,n,z,BW)
 if(nargin<4)
     BW = zeros(size(inputImage));
 end
%BW = bwconvhull(BW);
if(z==true)
    inputImage=imrotate(inputImage,90);
    BW=imrotate(BW,90);
end
%%

%%apply sobel filter to get Gradient Image
ENERGY_IMG=getEnergyImage(inputImage);
h=size(inputImage,1)+1;
M = max(max(ENERGY_IMG));
% thr = prctile(reshape(ENERGY_IMG,1,[]), 99);

for i=1:n
    %find a seam vector from the given energy map
    %ENERGY_IMG=getEnergyImage(inputImage); %added
    ENERGY_IMG(logical(BW))=M; %added
    seamVector=findSeam(ENERGY_IMG);
%     e = seamEnergy(ENERGY_IMG,seamVector);
%     if (e>thr)
%         i
%         break
%     end
    %add seam to the original image
    inputImage = addSeam(inputImage,seamVector);
    
    %also add seam in energy image
    ENERGY_IMG=addSeam(ENERGY_IMG,seamVector,1);
    BW=addSeam(BW,seamVector);
end
if(z==true)
    inputImage=imrotate(inputImage,-90);
end