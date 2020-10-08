function [c, ceq] = unitsphere(X)
%UNITSPHERE Calculates the sum of the distance of points in a matrix from
%the origin and  substracts the amount of points. If the points are on the
%unit sphere, the result will be 0.
%   It does not really calculate the sum, because it calculates the sum of
%   the squares of the coordinates for each point, not the square root of the sum
m=size(X,1);
n=size(X,2);
sum=0;
ceq=[];
for col=1:n
    for row=1:m
        sum=sum+(X(row,col))^2;
    end
    ceq=[ceq,1-sum];
    sum=0;
end
c=[];
        

end

