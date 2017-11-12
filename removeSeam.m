function returnImage=removeSeam(image,SeamVector)

[rows cols t]=size(image);
%returnImage=uint8(zeros(rows ,cols-1,t)); %%uint8 is important

returnImage=double(zeros(rows ,cols-1,t));
    for i=1:rows %size(SeamVector,1)
        for k=1:t
           returnImage(i,:,k)=[image(i,1:SeamVector(i)-1,k)  image(i,SeamVector(i)+1:cols,k)];
        end
    end
end


