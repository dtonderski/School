function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    numberOfCities = size(visibility,1);
    path = randi([1 numberOfCities]);
    while length(path)<numberOfCities
        path = [path GetNextCity(path, pheromoneLevel,visibility,alpha,beta)];
    end
end

