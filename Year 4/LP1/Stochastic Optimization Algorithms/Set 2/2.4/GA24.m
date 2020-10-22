clear all; close all; clc;
populationSize = 100;
minChromosomeLength = 12;
maxChromosomeLength = 60;
constants = -1;
numberOfConstants = length(constants);
numberOfRegisters = 4;
divisionByZeroResult = 1e15;
numberOfGenerations = 50000;
pTournament = 0.75;
tournamentSize = 5;
crossoverProbability = 0.2;
elitismCopies = 1;
maxLength = 120;
numberOfRuns = 5;
% mutation decreases with fitness, until it reaches a minimum of 0.04
initialMutationProbability = 0.3;
lowestMutationProbability = 0.04;
%bestEverChromosome = [1;2;3;1;3;2;1;3;1;2;3;1;4;1;6;1;4;1;6;1;1;2;3;1;1;2;3;1;3;3;6;2;1;1;2;5;1;1;2;5;3;2;1;3;1;1;2;5;1;1;2;5;1;1;2;5;4;1;6;1;3;2;1;3;1;2;3;1;1;2;3;1;1;1;2;5;4;1;6;1;1;2;3;1;4;1;6;1;4;1;6;1;3;2;1;3;1;1;2;5;4;1;6;1;4;1;6;1;3;2;1;3;1;2;3;1;4;1;6;1;1;2;3;1;3;3;6;2;1;1;2;5;4;1;6;1;3;2;1;3;1;2;3;1;1;2;3;1;1;2;3;1;1;2;3;1;1;2;3;1];
%%
runBestFitnessArray = [];
runBestChromosomeArray = [];
for iRun = 1:numberOfRuns
    
    fitness = zeros(populationSize, 1);
    population = InitializePopulation(populationSize, minChromosomeLength,...
        maxChromosomeLength, numberOfRegisters, numberOfConstants);
    
    for iGeneration = 1:numberOfGenerations
        maximumFitness = 0.0;
        bestIndividualIndex = 0;
        
        for i = 1:populationSize
            chromosome = population(i).Chromosome;
            fitness(i) = GetFitness(chromosome, constants, numberOfRegisters, divisionByZeroResult, maxLength);
            if fitness(i) > maximumFitness
                maximumFitness = fitness(i);
                bestIndividualIndex = i;
            end
        end
        
        tempPopulation = population;
        mutationProbability = max(lowestMutationProbability, initialMutationProbability/maximumFitness);
        
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

        fprintf('Run %d, generation %d, maximum fitness %.4f.\n',...
            iRun, iGeneration, maximumFitness);
    end
    runBestFitnessArray = [runBestFitnessArray, maximumFitness];
    runBestChromosomeArray = [runBestChromosomeArray, population(bestIndividualIndex)];
end
%%
% [bestRunFitness, bestRunIndex] = max(runBestFitnessArray);
% bestChromosome = runBestChromosomeArray(bestRunIndex).Chromosome; 
bestChromosome = population(1).Chromosome;
expression = VisualiseChromosome(bestChromosome, constants, numberOfRegisters, divisionByZeroResult);
disp(expression);
disp(simplify(expression));
GetFitness(bestChromosome,constants,numberOfRegisters,divisionByZeroResult,maxLength)
