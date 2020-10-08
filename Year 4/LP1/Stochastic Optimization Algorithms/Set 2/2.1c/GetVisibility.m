function visibility = GetVisibility(cityLocation)
N = size(cityLocation,1);
visibility = zeros(N);
for i = 1:N
    for j = 1:N
        visibility(i,j) = 1/GetDistance(cityLocation, j, i);
    end
end
end

