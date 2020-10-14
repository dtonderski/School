clear all; close all; clc;
INF = 1e100;
populationSize = 100;
minChromosomeLength = 12;
maxChromosomeLength = 48;
constants = -1;
numberOfConstants = length(constants);
numberOfRegisters = 4;
divisionByZeroResult = 1e5;
%numberOfGenerations = 1000;
pTournament = 0.75;
tournamentSize = 5;
crossoverProbability = 0.1;
elitismCopies = 1;
maxLength = 120;
numberOfRuns = 1;
mutationProbability = 0.04;
%bestEverChromosome = [1;2;3;1;3;2;1;3;1;2;3;1;4;1;6;1;4;1;6;1;1;2;3;1;1;2;3;1;3;3;6;2;1;1;2;5;1;1;2;5;3;2;1;3;1;1;2;5;1;1;2;5;1;1;2;5;4;1;6;1;3;2;1;3;1;2;3;1;1;2;3;1;1;1;2;5;4;1;6;1;1;2;3;1;4;1;6;1;4;1;6;1;3;2;1;3;1;1;2;5;4;1;6;1;4;1;6;1;3;2;1;3;1;2;3;1;4;1;6;1;1;2;3;1;3;3;6;2;1;1;2;5;4;1;6;1;3;2;1;3;1;2;3;1;1;2;3;1;1;2;3;1;1;2;3;1;1;2;3;1];
%%
runBestFitnessArray = [];
runBestChromosomeArray = [];
for iRun = 1:numberOfRuns
    fitness = zeros(populationSize, 1);
    population = InitializePopulation(populationSize, minChromosomeLength,...
        maxChromosomeLength, numberOfRegisters, numberOfConstants);
    
    maximumFitness = -INF;
    iGeneration = 0;
    while maximumFitness < 10
        iGeneration = iGeneration+1;
        maximumFitness = -INF;
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
