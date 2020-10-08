function deltaTau = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)
deltaTau = zeros(size(pathCollection));
for iPath = 1:size(pathCollection,1)
    for iEdge = 1:size(pathCollection,2)-1
        start = pathCollection(iPath,iEdge);
        stop = pathCollection(iPath,iEdge+1);
        distance = pathLengthCollection(iPath);
        deltaTau(stop, start) = deltaTau(stop, start)+1/distance;
        deltaTau(start, stop) = deltaTau(start, stop)+1/distance;
    end
    start = pathCollection(iPath,end);
    stop = pathCollection(iPath,1);
    distance = pathLengthCollection(iPath);
    deltaTau(stop, start) = deltaTau(stop, start)+1/distance;
    deltaTau(start, stop) = deltaTau(start, stop)+1/distance;
end
end

