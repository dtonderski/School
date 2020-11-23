function [forest, treeLocations, fireLocations] = InitializeForest(latticeSize,initialTreeFraction)
%INITIALIZEPOPULATION Summary of this function goes here
%   0 - empty
%   1 - tree
%   2 - fire

forest = zeros(latticeSize);
random = rand(latticeSize);

forest(random < initialTreeFraction) = 1;

[treeLocationsX, treeLocationsY] = find(forest == 1);
treeLocations = [treeLocationsX, treeLocationsY];

fireLocations = double.empty(0,2);

end

