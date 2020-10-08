clc, clear all
cityLocation = LoadCityLocations;
N = size(cityLocation, 1);
pathLength = 0;
path = randi([1 N]);
while length(path)<N
    nextCity = GetClosestCity(cityLocation, path);
    pathLength = pathLength + GetDistance(cityLocation, path(end), nextCity);
    path = [path, nextCity];
end
pathLength = pathLength + GetDistance(cityLocation, path(1), path(end));
fprintf("Starting city: %d, path length %.5f.\n", path(1), pathLength)
