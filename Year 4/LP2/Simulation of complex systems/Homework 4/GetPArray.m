function [kArray, PArray] = GetPArray(M, iMax)
i = 0;
n = size(M,2);
MSum = sum(M,2);
for k = 1:n

    P(k) = length(find(MSum == k));
    if P(k) == 0
        i = i+1;
        if i > iMax
            break
        end
    end
end
kArray = 1:length(P);
PArray = P/sum(P);
end

