function [susceptible, infected, recovered] = InitializePopulation(nAgents, infectedProportion, xRange, yRange)
nInfected           = round(nAgents*infectedProportion);
nSusceptible        = nAgents - nInfected;

susceptible         = zeros(nSusceptible, 2);
susceptible(:,1)    = randi(xRange, nSusceptible, 1);
susceptible(:,2)    = randi(yRange, nSusceptible, 1);

infected            = zeros(nInfected, 2);
infected(:,1)       = randi(xRange, nInfected, 1);
infected(:,2)       = randi(yRange, nInfected, 1);

recovered = [];

end

