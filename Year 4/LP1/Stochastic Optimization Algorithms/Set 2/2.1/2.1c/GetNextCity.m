function nextCity = GetNextCity(path, pheromoneLevel,visibility,alpha,beta)
numberOfCities = size(visibility,1);
possibleCities = setdiff(1:numberOfCities, path);
currentCity = path(end);
numberOfPossibleNextCities = length(possibleCities);
theta = zeros(numberOfPossibleNextCities, 1);

% Here, fitness and theta are uses as in usual roulette wheel selection
fitness = zeros(numberOfPossibleNextCities,1);
for jTheta = 1:numberOfPossibleNextCities
    nextCityCandidate = possibleCities(jTheta);
    fitness(jTheta) = pheromoneLevel(nextCityCandidate,currentCity).^alpha...
        *visibility(nextCityCandidate,currentCity).^beta;
end

for jTheta = 1:numberOfPossibleNextCities
    theta(jTheta) = sum(fitness(1:jTheta));
end

% It very rarely happens that theta only contains zeros. To avoid division
% by zero, the last index is then set to 1, and the rest is left as is.
if sum(fitness) ~= 0 
    theta = theta/sum(fitness);
else
    theta(end) = 1;
end

r = rand;
for jTheta = 1:numberOfPossibleNextCities
    if theta(jTheta) >= r
        nextCity = possibleCities(jTheta);
        return
    end
end
end

