function [forest, treeLocations] = GrowForest(forest, latticeSize, growthProbability)

forest(rand(latticeSize) < growthProbability) = 1;

[treeLocationsX, treeLocationsY] = find(forest == 1);
treeLocations = [treeLocationsX, treeLocationsY];


end

