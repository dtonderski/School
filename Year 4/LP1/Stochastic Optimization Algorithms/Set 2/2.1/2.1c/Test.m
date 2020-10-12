clf
clear all
cityLocation = LoadCityLocations;
N = size(cityLocation,1);
startCity = 1;
path = startCity;
while length(path)<N
    nextCity = getNextCity(cityLocation, path(end), path);
    path = [path, nextCity];
end

tspFigure = InitializeTspPlot(cityLocation,[0 20 0 20]); 
connection = InitializeConnections(cityLocation); 
PlotPath(connection,cityLocation,path);

for i = 1:N
    hold on
    plot(cityLocation(path(i),1), cityLocation(path(i),2),'or')
    pause(0.5)
end


function nextCity = getNextCity(cityLocation, currentCity, visitedCities)
    N = size(cityLocation, 1);
    possibleCities = setdiff(1:N, [currentCity, visitedCities]);
    nextCity = possibleCities(1);
    minDistance = getDistance(cityLocation, nextCity, currentCity);
    for j = possibleCities(2:end)
        tempDistance = getDistance(cityLocation, currentCity, j);
        if tempDistance < minDistance
            minDistance = tempDistance;
            nextCity = j;
        end
    end
end

function distance = getDistance(cityLocation, city1, city2)
    start = cityLocation(city1,:);
    stop = cityLocation(city2,:);
    distance = norm(start-stop);
end
