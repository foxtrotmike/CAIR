function SeamVector=findSeam(x)
%% x is and energy image i.e. gradient image
% this function will return seamVector
%x=findSeamImage(x);
x=dynamicProgramming(x); % net is the alternative of findSeamImage it is implemented in C++

[rows cols]=size(x);
%% backtracking to find the seam vector
for i=rows:-1:1
    if i==rows
        [value, j]=min(x(rows,:));  %finds min value of last row
    else    %accounts for boundary issues
        if SeamVector(i+1)==1
            Vector=[Inf x(i,SeamVector(i+1)) x(i,SeamVector(i+1)+1)];
        elseif SeamVector(i+1)==cols
            Vector=[x(i,SeamVector(i+1)-1) x(i,SeamVector(i+1)) Inf];
        else
            Vector=[x(i,SeamVector(i+1)-1) x(i,SeamVector(i+1)) x(i,SeamVector(i+1)+1)];
        end
        
        %find min value and index of 3 neighboring pixels in prev. row.
        [Value Index]=min(Vector);
        IndexIncrement=Index-2;
        j=SeamVector(i+1)+IndexIncrement;
    end
    SeamVector(i,1)=j;
end
