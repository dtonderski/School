function distance = GetDistance(cityLocation, city1, city2)
    start = cityLocation(city1,:);
    stop = cityLocation(city2,:);
    distance = norm(start-stop);
end
