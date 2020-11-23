clear, clc
latticeSize = 128;
initialTreeFraction = 0.1;
growthProbability = 0.01;
lightningProbability = 1;
timeSteps = 1000;
pauseTime = 0.01;
showForestEvolution = false;

[forest, treeLocations, fireLocations] = InitializeForest(latticeSize, initialTreeFraction);

fireSizes = [];
densities = [];
tic
for t = 1:timeSteps
    [forest, treeLocations] = GrowForest(forest, latticeSize, growthProbability);
    [forest, treeLocations, fireLocations] = LightningStrike(forest, treeLocations, fireLocations, lightningProbability);
    if ~isempty(fireLocations)
        figure(1)
        [forest, treeLocations, fireLocations] = SimulateFires(forest, fireLocations);
        fireSize = length(fireLocations);
        fireSizes = [fireSizes, fireSize];
        densities = [densities, (length(treeLocations) + length(fireLocations))/latticeSize^2];
        

        if showForestEvolution
            pause(pauseTime)
            ShowForest(treeLocations, fireLocations)
        end
        
         if fireSize >= median(fireSizes) && fireSize < mean(fireSizes)
             fireTreeLocations = treeLocations;
             fireFireLocations = fireLocations;
         end
        
        [forest, fireLocations] = BurnDownTrees(forest);
        if showForestEvolution
            pause(pauseTime)
            ShowForest(treeLocations, fireLocations)
        end

    end
    if showForestEvolution
        pause(pauseTime)
        ShowForest(treeLocations, fireLocations)
    end
end
toc
%%
ShowForest(fireTreeLocations,fireFireLocations)
fprintf('p = %.3f, f = %.3f\n', growthProbability, lightningProbability)
title(sprintf('Typical fire in %d time steps, $p = %.4f, f = %.2f$', timeSteps, growthProbability, lightningProbability), 'Interpreter', 'latex')
disp((length(treeLocations)+ length(fireLocations))/latticeSize^2)

