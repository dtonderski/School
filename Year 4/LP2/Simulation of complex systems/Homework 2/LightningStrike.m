function [forest, treeLocations, fireLocations] = LightningStrike(forest, treeLocations, fireLocations, lightningProbability)

if rand < lightningProbability && ~isempty(treeLocations)
    struckTreeIndex = randi(size(treeLocations,1));
    fireLocations = treeLocations(struckTreeIndex, :);
    treeLocations(struckTreeIndex, :) = [];
    forest(fireLocations(1), fireLocations(2)) = 2;
end
end
