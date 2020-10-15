function pathLength = GetPathLength(path, cityLocation)
numberOfCities = length(path);
pathLength = 0;
for i = 1:numberOfCities-1
    pathLength = pathLength + GetDistance(cityLocation, path(i), path(i+1));
end
pathLength = pathLength + GetDistance(cityLocation, path(1), path(numberOfCities));
end

