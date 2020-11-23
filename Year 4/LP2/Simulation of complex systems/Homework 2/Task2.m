clear, clc
latticeSize = 128;
initialTreeFraction = 0.5;
growthProbability = 0.01;
lightningProbability = 1;
timeSteps = 10000;

simulationFireSizes = [];
generatedFireSizes  = [];

[forest, treeLocations, fireLocations] = InitializeForest(latticeSize, initialTreeFraction);

tic
for t = 1:timeSteps
    [forest, treeLocations] = GrowForest(forest, latticeSize, growthProbability);
    [forest, treeLocations, fireLocations] = LightningStrike(forest, treeLocations, fireLocations, lightningProbability);
    if ~isempty(fireLocations)
        [forest, treeLocations, fireLocations] = SimulateFires(forest, fireLocations);        
        simulationFireSizes = [simulationFireSizes, size(fireLocations,1) / latticeSize^2];
        density  = (size(fireLocations,1) + size(treeLocations,1)) / latticeSize^2;
        generatedFireSizes = [generatedFireSizes, GetGeneratedFireSize(latticeSize, density)];
        
        [forest, fireLocations] = BurnDownTrees(forest);
    end
end
toc

%%
clf
numberOfFires = length(simulationFireSizes);
rank = [1:numberOfFires] / numberOfFires;

simulationFireSizes = flip(sort(simulationFireSizes));
generatedFireSizes = flip(sort(generatedFireSizes));

loglog(simulationFireSizes, rank, '.')
hold on
loglog(generatedFireSizes, rank, '.')

xlabel('Relative fire size')
ylabel('Rank')
title(sprintf('$p = %.4f, f = %.2f$', growthProbability, lightningProbability), 'interpreter', 'latex')
legend('Simulation', 'Generated forests')
%% Functions

function generatedFireSize = GetGeneratedFireSize(latticeSize, density)
    [forest, treeLocations, fireLocations] = InitializeForest(latticeSize, density);
    [forest, ~, fireLocations] = LightningStrike(forest, treeLocations, fireLocations, 1);
    [~, ~, fireLocations] = SimulateFires(forest, fireLocations);        

    generatedFireSize = size(fireLocations,1) / latticeSize^2;
end

