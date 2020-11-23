function [forest, treeLocations, fireLocations] = LightningStrike(forest, treeLocations, fireLocations, lightningProbability, latticeSize)

[lightningLocationsX, lightningLocationsY] = find(rand(latticeSize) < lightningProbability);
lightningLocations = [lightningLocationsX, lightningLocationsY];

for i = 1:size(lightningLocations, 1)
    [tf, index] = ismember(treeLocations, lightningLocations(i,:), 'rows');
    if any(tf)
        treeLocations(find(index), :) = [];
        fireLocations = [fireLocations; lightningLocations(i,:)];
        forest(lightningLocations(i,1), lightningLocations(i,2)) = 2;
    end
end
end

