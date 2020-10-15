function deltaTau = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)
deltaTau = zeros(size(pathCollection));
for iPath = 1:size(pathCollection,1)
    for iEdge = 1:size(pathCollection,2)-1
        startCity = pathCollection(iPath,iEdge);
        endCity = pathCollection(iPath,iEdge+1);
        distance = pathLengthCollection(iPath);
        deltaTau(endCity, startCity) = deltaTau(endCity, startCity)+1/distance;
    end
    startCity = pathCollection(iPath,end);
    endCity = pathCollection(iPath,1);
    distance = pathLengthCollection(iPath);
    deltaTau(endCity, startCity) = deltaTau(endCity, startCity)+1/distance;
end
end

