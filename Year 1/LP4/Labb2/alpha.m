function alphamin = alpha(A)
%ALPHA Calculates relative diagonal dominance of a square matrix
%   Detailed explanation goes here
n=size(A,1);
difference=[];
sumtemp=0;
for row=1:n
    for col=1:n
        if row~=col
            sumtemp=sumtemp+abs(A(row,col));
        end
    end
    difference=[difference, (A(row,row)-sumtemp)./A(row,row)];
end
alphamin=min(difference);




end

