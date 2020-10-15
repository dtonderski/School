function visibility = GetVisibility(cityLocation)
numberOfCities = size(cityLocation,1);
visibility = zeros(numberOfCities);
for i = 1:numberOfCities
    for j = 1:numberOfCities
        visibility(i,j) = 1/GetDistance(cityLocation, j, i);
    end
end
end

