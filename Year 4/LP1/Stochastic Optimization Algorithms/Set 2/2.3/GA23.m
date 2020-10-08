clear all; clc;
INF = 1e50;
populationSize = 100;
NH = 7;
numberOfGenes = NH*(3+1) + 2*(NH+1);
mutationProbability = 1/numberOfGenes;
creepRate = 0.05;
pTournament = 0.9;
tournamentSize = 2;
crossoverProbability = 0.1; 
elitismCopies = 1;
numberOfGenerations = 1000;
initialWeightRange = 1;

fitness = zeros(populationSize,1);
validationFitness = zeros(populationSize, 1);
maximumValidationFitness = -INF;
population = InitializePopulation(populationSize, numberOfGenes, initialWeightRange);

fitnessArray = [];
validationFitnessArray = [];

for iGeneration = 1:numberOfGenerations
    maximumFitness = -INF;
    for i = 1:populationSize
        chromosome = population(i,:);
        fitness(i) = GetFitness(chromosome, NH, 1);
        if fitness(i) > maximumFitness
            maximumFitness = fitness(i);
            bestIndividualIndex = i;
            bestChromosome = chromosome;
        end
        validationFitness(i) = GetFitness(chromosome, NH, 2);
        if validationFitness(i) > maximumValidationFitness
            maximumValidationFitness = validationFitness(i);
        end
    end
    disp(iGeneration)
    disp(maximumFitness)
    disp(maximumValidationFitness)
    fitnessArray = [fitnessArray, maximumFitness];
    validationFitnessArray = [validationFitnessArray, maximumValidationFitness];
    tempPopulation = population;

    for i = 1:2:populationSize
        i1 = TournamentSelect(fitness, pTournament, tournamentSize);
        i2 = TournamentSelect(fitness, pTournament, tournamentSize);
        chromosome1 = population(i1, :);
        chromosome2 = population(i2, :);

        r = rand;
        if r < crossoverProbability
            newChromosomePair = Cross(chromosome1, chromosome2);
            tempPopulation(i, :) = newChromosomePair(1,:);
            tempPopulation(i+1,:) = newChromosomePair(2,:);
        else
            tempPopulation(i, :) = chromosome1;
            tempPopulation(i+1, :) = chromosome2;
        end
    end

    for i = 1:populationSize
        originalChromosome = tempPopulation(i,:);
        mutatedChromosome = Mutate(originalChromosome, mutationProbability, creepRate);
        tempPopulation(i,:) = mutatedChromosome;
    end

    tempPopulation = InsertBestIndividual(tempPopulation, ...
        population(bestIndividualIndex,:), elitismCopies);
    population = tempPopulation;    
end
