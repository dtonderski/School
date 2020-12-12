function [averagePathLength, diameter] = GetAveragePathLength(M)
n = size(M,1);
pathLengthMatrix = zeros(size(M));
M_k = 1;
for k = 1:n
    M_k = M_k*M;
    pathLengthMatrix(M_k > 0 & pathLengthMatrix == 0) = k;
    if all(pathLengthMatrix~=0)
        break;
    end
end

pathLengthMatrix = pathLengthMatrix - diag(diag(pathLengthMatrix));

averagePathLength = (sum(sum((pathLengthMatrix))))/(n^2-n);
diameter = max(max(pathLengthMatrix));

end

