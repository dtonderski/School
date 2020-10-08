function d = distance(X)
%DISTANCE Calculates sum of distances betweens n points defined by a matrix X
%   The points' coordinates are the columns of the matrix
m=size(X,1);
n=size(X,2);
sum=0;
sumtemp=0;

for col1=1:n-1
    for col2=col1+1:n
        for row=1:m
            sumtemp=sumtemp + (X(row,col1)-X(row,col2)).^2;
        end
        sum = sum + sqrt(sumtemp);
        sumtemp=0;
    end
end
d=-sum;
end


