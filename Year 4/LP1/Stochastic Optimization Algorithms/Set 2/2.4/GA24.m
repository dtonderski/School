clear all; close all; clc;
INF = 1e100;
populationSize = 100;
minChromosomeLength = 40;
maxChromosomeLength = 80;
constants = [1 3 10];
numberOfConstants = length(constants);
numberOfRegisters = 5;
divisionByZeroResult = 1e10;
numberOfGenerations = 700000;
pTournament = 0.75;
tournamentSize = 2;
crossoverProbability = 0.5;
elitismCopies = 1;
maxLength = 300;

%finalMutationProbability = 0.1;
%finalMutationProbabilityGenerations = 5000;
%maxGenerationsWithoutImprovement = 10000;
%%
fitness = zeros(populationSize, 1);
population = InitializePopulation(populationSize, minChromosomeLength,...
    maxChromosomeLength, numberOfRegisters, numberOfConstants);

generationsSinceLastImprovement = 0;
previousMaximumFitness = 0;
for iGeneration = 1:numberOfGenerations
    generationsSinceLastImprovement = generationsSinceLastImprovement + 1;
    maximumFitness = -INF;
    bestIndividualIndex = 0;
    for i = 1:populationSize
        chromosome = population(i).Chromosome;
        fitness(i) = GetFitness(chromosome, constants, numberOfRegisters, divisionByZeroResult, maxLength);
        if fitness(i) > maximumFitness
            maximumFitness = fitness(i);
            if maximumFitness > previousMaximumFitness
                previousMaximumFitness = maximumFitness;
                generationsSinceLastImprovement = 0;
            end
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
        % The mutation probability should approach finalMutationProbability as the
        % number of generations since the last improvement approaches 5000
        % mutationProbability = min(finalMutationProbability, 1/length(chromosome) * exp(generationsSinceLastImprovement/finalMutationProbabilityGenerations * log(finalMutationProbability*length(chromosome))));
        mutationProbability = 1/length(chromosome);
        mutatedChromosome = Mutate(chromosome, mutationProbability, numberOfRegisters, numberOfConstants);
        tempPopulation(i) = struct('Chromosome', mutatedChromosome);
    end
    tempPopulation = InsertBestIndividual(tempPopulation, ...
        population(bestIndividualIndex), elitismCopies);
    
    % If there have been 10000 generations without an improvement, save the
    % best value and restart
    if generationsSinceLastImprovement == maxGenerationsWithoutImprovement
        generationsSinceLastImprovement = 0;
        tempPopulation = InitializePopulation(populationSize, minChromosomeLength,...
            maxChromosomeLength, numberOfRegisters, numberOfConstants);
        tempPopulation = InsertBestIndividual(tempPopulation, ...
            population(bestIndividualIndex), elitismCopies);
    end

    population = tempPopulation; 
    
    fprintf('In generation %d, maximum fitness is %.4f. Generations since last improvement: %d.\n',...
        iGeneration, maximumFitness, generationsSinceLastImprovement);
end
%%
bestChromosome = population(bestIndividualIndex).Chromosome;
expression = VisualiseChromosome(population(bestIndividualIndex).Chromosome, constants, numberOfRegisters, divisionByZeroResult);
disp(expression);
disp(simplify(expression));
GetFitness(bestChromosome,constants,numberOfRegisters,divisionByZeroResult,maxLength)
