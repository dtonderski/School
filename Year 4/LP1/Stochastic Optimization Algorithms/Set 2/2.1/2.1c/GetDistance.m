function distance = GetDistance(cityLocation, city1, city2)
    startLocation = cityLocation(city1,:);
    endLocation = cityLocation(city2,:);
    distance = norm(startLocation-endLocation);
end
