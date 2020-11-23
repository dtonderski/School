%%
clear, clc
initialTreeFraction = 0.5;
growthProbability = 0.01;
lightningProbability = 1;
timeSteps = 1000;
latticeSizeArray = 2.^(3:9);
tauArray = zeros(size(latticeSizeArray));
tic
for iLatticeSize = 1:length(latticeSizeArray)
    disp(iLatticeSize)
    latticeSize = latticeSizeArray(iLatticeSize);
    simulationFireSizes = [];

    [forest, treeLocations, fireLocations] = InitializeForest(latticeSize, initialTreeFraction);
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
    
    numberOfFires = length(simulationFireSizes);
    rank = [1:numberOfFires] / numberOfFires;

    simulationFireSizes = flip(sort(simulationFireSizes));
    
    x = simulationFireSizes;
    y = rank;
    c = polyfit(log(x),log(y),1);
    ybl = simulationFireSizes.^c(1).*exp(c(2));
    tauArray(iLatticeSize) = 1-c(1);
    
end
toc
%%
clf
plot(latticeSizeArray, tauArray, 'x')

x0 = [22, 1.15];
fitfun = fittype( @(a,c,x) a./x+c );
[fitted_curve, gof] = fit(latticeSizeArray',tauArray',fitfun, 'StartPoint', x0);
c = coeffvalues(fitted_curve);

hold on
x = linspace(min(latticeSizeArray)-1, max(latticeSizeArray)+20);
plot(x, c(1)./x + c(2))
xlabel('Lattice size', 'interpreter', 'latex')
ylabel('$\tau$', 'interpreter', 'latex')
legend('Data', sprintf('$%.2f / x + %.2f$', c(1), c(2)), 'interpreter', 'latex')
title(sprintf('$p = %.4f, f = %.2f, \\tau(\\infty) \\approx %.2f$', growthProbability, lightningProbability, ...
    c(2)), 'interpreter', 'latex')



