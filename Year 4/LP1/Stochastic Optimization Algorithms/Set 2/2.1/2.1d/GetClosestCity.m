function nextCity = GetClosestCity(cityLocation, tabuList)
    N = size(cityLocation, 1);
    possibleCities = setdiff(1:N, tabuList);
    nextCity = possibleCities(1);
    currentCity = tabuList(end);
    minDistance = GetDistance(cityLocation, nextCity, currentCity);
    for j = possibleCities(2:end)
        tempDistance = GetDistance(cityLocation, currentCity, j);
        if tempDistance < minDistance
            minDistance = tempDistance;
            nextCity = j;
        end
    end
end