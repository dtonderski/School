%% Initialization
clear all; close all; clc;
%% Parameters
INF = 1e100;
populationSize = 100;
minStartChromosomeLength = 24;
maxStartChromosomeLength = 100;
constants = [1,3,10];
numberOfConstants = length(constants);
numberOfRegisters = 4;
divisionByZeroResult = 1e10;
numberOfGenerations = 10000;
pTournament = 0.75;
tournamentSize = 5;
crossoverProbability = 0.1;
elitismCopies = 1;
maxChromosomeLength = 160;
numberOfRuns = 1;
mutationProbability = 0.04;
%% Algorithm
fitness = zeros(populationSize, 1);
population = InitializePopulation(populationSize, minStartChromosomeLength,...
    maxStartChromosomeLength, numberOfRegisters, numberOfConstants);
    
for iGeneration = 1:numberOfGenerations
    maximumFitness = -INF;
    bestIndividualIndex = 0;
    for i = 1:populationSize
        chromosome = population(i).Chromosome;
        fitness(i) = GetFitness(chromosome, constants, numberOfRegisters, divisionByZeroResult, maxChromosomeLength);
        if fitness(i) > maximumFitness
            maximumFitness = fitness(i);
            bestIndividualIndex = i;
        end
    end

    tempPopulation = population;

    for i = 1:2:populationSize
        i1 = TournamentSelect(fitness, pTournament, tournamentSize);
        i2 = TournamentSelect(fitness, pTournament, tournamentSize);
        chromosome1 = population(i1).Chromosome;
        chromosome2 = population(i2).Chromosome;

        r = rand;
        if r < crossoverProbability
            [chromosome1, chromosome2] = TwoPointCross(chromosome1, chromosome2);
        end
        tempPopulation(i) = struct('Chromosome',chromosome1);
        tempPopulation(i+1) = struct('Chromosome',chromosome2);
    end

    for i = 1:populationSize
        chromosome = population(i).Chromosome;
        mutatedChromosome = Mutate(chromosome, mutationProbability, numberOfRegisters, numberOfConstants);
        tempPopulation(i) = struct('Chromosome', mutatedChromosome);
    end
    tempPopulation = InsertBestIndividual(tempPopulation, ...
        population(bestIndividualIndex), elitismCopies);

    population = tempPopulation; 

    fprintf('Generation %d, maximum fitness %.4f.\n',...
        iGeneration, maximumFitness);
end

%% Output
fprintf('The total error for the best found chromosome is %.4f\n', 1/maximumFitness);