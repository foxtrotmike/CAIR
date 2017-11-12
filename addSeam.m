function returnImage=addSeam(image,SeamVector,s)
%s should be given as 1 only for seam addition to the energy map
if(nargin<3)
    s=0;
end
[rows cols t]=size(image);
%returnImage=uint8(zeros(rows ,cols-1,t)); %%uint8 is important
M=max(max(abs(image)));
returnImage=(zeros(rows ,cols+1,t));
if(s)
    for i=1:rows
        for k=1:t            
            image(i,SeamVector(i):min(SeamVector(i)+1,cols),k)=M;            
            returnImage(i,:,k)=[image(i,1:SeamVector(i),k)  M image(i,SeamVector(i)+1:cols,k)];
            %this step makes sure that the same seam is not selected over
            %and over again 
        end
    end
else
    for i=1:rows
        for k=1:t            
            z=mean([image(i,SeamVector(i),k) image(i,min(SeamVector(i)+1,cols),k)]);            
            returnImage(i,:,k)=[image(i,1:SeamVector(i),k)  z image(i,SeamVector(i)+1:cols,k)];
        end
    end
end



