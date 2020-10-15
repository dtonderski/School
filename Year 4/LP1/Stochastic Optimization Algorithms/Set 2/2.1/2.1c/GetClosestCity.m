function nextCity = GetClosestCity(cityLocation, tabuList)
    numberOfCities = size(cityLocation, 1);
    possibleCities = setdiff(1:numberOfCities, tabuList);
    nextCity = possibleCities(1);
    currentCity = tabuList(end);
    minDistance = GetDistance(cityLocation, nextCity, currentCity);
    for iNextCity = possibleCities(2:end)
        tempDistance = GetDistance(cityLocation, currentCity, iNextCity);
        if tempDistance < minDistance
            minDistance = tempDistance;
            nextCity = iNextCity;
        end
    end
end