%% Initialization
clear all; close all; clc;
%% Constants
cityLocations = LoadCityLocations;
INF = 1e100;
populationSize = 100;
nCities = size(cityLocations, 1);
mutationProbability = 0.02;
pTournament = 0.8;
tournamentSize = 2;
numberOfGenerations = 10000;
elitismCopies = 1;
numberOfRuns = 20;

%% Plotting
figure(1)
clf
cityLocation = LoadCityLocations;
tspFigure = InitializeTspPlot(cityLocation,[0 20 0 20]); 
connection = InitializeConnections(cityLocation); 

%% Run GA
bestChromosome = zeros(1,nCities);
bestFitness = 0;
population = InitializePopulation(populationSize, nCities);
fitness = zeros(populationSize,1);
bestFitnessArray = zeros(1, numberOfGenerations);

for iGeneration = 1:numberOfGenerations
    for i = 1:populationSize
        chromosome = population(i,:);
        fitness(i) = EvaluateIndividual(chromosome,cityLocations);
    end
    [maximumFitness, bestIndividualIndex] = max(fitness);
    bestChromosome = population(bestIndividualIndex, :);
    bestFitnessArray(iGeneration) = maximumFitness;

    tempPopulation = population;

    for i = 1:2:populationSize
        i1 = TournamentSelect(fitness, pTournament, tournamentSize);
        i2 = TournamentSelect(fitness, pTournament, tournamentSize);
        chromosome1 = population(i1, :);
        chromosome2 = population(i2, :);
        tempPopulation(i, :) = chromosome1;
        tempPopulation(i+1, :) = chromosome2;
    end

    for i = 1:populationSize
        originalChromosome = tempPopulation(i,:);
        mutatedChromosome = Mutate(originalChromosome, mutationProbability);
        tempPopulation(i,:) = mutatedChromosome;
    end

    tempPopulation = InsertBestIndividual(tempPopulation, ...
        population(bestIndividualIndex,:), elitismCopies);
    population = tempPopulation;
    if iGeneration>1
        if bestFitnessArray(iGeneration) > bestFitnessArray(iGeneration-1)
            PlotPath(connection,cityLocation,bestChromosome);
        end
    end
end

fprintf('The shortest path found with the GA has length is %.4f.\n', 1/maximumFitness);

