function CDF = GetCDF(PArray, kArray)

for k = kArray
    CDF(k) = sum(PArray(1:k));
end
CDF = CDF/CDF(end);

end

