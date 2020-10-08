function pathLength = GetNearestNeighbourPathLength(cityLocation)
    N = size(cityLocation, 1);
    pathLength = 0;
    tabuList = randi([1 N]);
    while length(tabuList)<N
        nextCity = GetClosestCity(cityLocation, tabuList);
        pathLength = pathLength + GetDistance(cityLocation, tabuList(end), nextCity);
        tabuList = [tabuList, nextCity];
    end
    pathLength = pathLength + GetDistance(cityLocation, tabuList(1), tabuList(end));
end



