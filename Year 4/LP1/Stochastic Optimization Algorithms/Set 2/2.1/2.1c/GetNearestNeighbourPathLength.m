function pathLength = GetNearestNeighbourPathLength(cityLocation)
    numberOfCities = size(cityLocation, 1);
    pathLength = 0;
    tabuList = randi([1 numberOfCities]);
    while length(tabuList)<numberOfCities
        nextCity = GetClosestCity(cityLocation, tabuList);
        pathLength = pathLength + GetDistance(cityLocation, tabuList(end), nextCity);
        tabuList = [tabuList, nextCity];
    end
    pathLength = pathLength + GetDistance(cityLocation, tabuList(1), tabuList(end));
end



