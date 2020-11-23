%%
clear, clc
latticeSize = 128;
initialTreeFraction = 0.5;
growthProbability = 0.01;
lightningProbability = 1;
timeSteps = 1000;

simulationFireSizes = [];

[forest, treeLocations, fireLocations] = InitializeForest(latticeSize, initialTreeFraction);
tic
for t = 1:timeSteps
    [forest, treeLocations] = GrowForest(forest, latticeSize, growthProbability);
    [forest, treeLocations, fireLocations] = LightningStrike(forest, treeLocations, fireLocations, lightningProbability);
    if ~isempty(fireLocations)
        [forest, treeLocations, fireLocations] = SimulateFires(forest, fireLocations);        
        simulationFireSizes = [simulationFireSizes, size(fireLocations,1) / latticeSize^2];
        density  = (size(fireLocations,1) + size(treeLocations,1)) / latticeSize^2;
        
        [forest, fireLocations] = BurnDownTrees(forest);
    end
end
toc
%%
clf
numberOfFires = length(simulationFireSizes);
rank = [1:numberOfFires] / numberOfFires;

simulationFireSizes = flip(sort(simulationFireSizes));

loglog(simulationFireSizes, rank, '.')
hold on

xlabel('Relative fire size', 'interpreter', 'latex')
ylabel('Rank', 'interpreter', 'latex')
%%
x = simulationFireSizes(simulationFireSizes < 5e-3);
y = rank(end-length(x)+1:end);
c = polyfit(log(x),log(y),1);
ybl = simulationFireSizes.^c(1).*exp(c(2));
loglog(simulationFireSizes, ybl)
tau = 1-c(1);
disp(tau)
title(sprintf('$p = %.4f, f = %.2f, \\tau = %.3f$', growthProbability, lightningProbability, tau), 'interpreter', 'latex')
%%
dataSize = 50;
xMin = min(simulationFireSizes);
r = rand(1,dataSize);
xPowerLaw = xMin.*power((1-r),(-(1/(tau-1))));
xPowerLaw = flip(sort(xPowerLaw));
loglog(xPowerLaw,(1:dataSize)/dataSize)
legend('Simulation data', 'Linear fit', 'Power law data', 'interpreter', 'latex')




