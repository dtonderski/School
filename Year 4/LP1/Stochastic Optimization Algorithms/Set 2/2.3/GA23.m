%% Initialization
clear all; clc; close all;
%% Parameters
INF = 1e50;
populationSize = 100;
numberOfHiddenNeurons = 8;
numberOfGenes = numberOfHiddenNeurons*(3+1) + 2*(numberOfHiddenNeurons+1);
creepMutationProbability = 1/numberOfGenes;
ordinaryMutationProbability = 1/numberOfGenes;
crossoverProbability = 0.3; 
elitismCopies = 1;
numberOfGenerations = 500;
weightRange = 10;
creepRate = weightRange/4;
slopeLength = 1000;
pTournament = 0.9;
tournamentSize = 2;
%% Training

fitness = zeros(populationSize,1);
population = InitializePopulation(populationSize, numberOfGenes, weightRange);

fitnessArray = [];
validationFitnessArray = [];

for iGeneration = 1:numberOfGenerations
    maximumFitness = -INF;
    maximumValidationFitness = -INF;
    for i = 1:populationSize
        chromosome = population(i,:);
        fitness(i) = GetFitness(chromosome, numberOfHiddenNeurons, slopeLength, 1);
        if fitness(i) > maximumFitness
            maximumFitness = fitness(i);
            bestIndividualIndex = i;
            bestChromosome = chromosome;
            validationFitness = GetFitness(chromosome, numberOfHiddenNeurons, slopeLength, 2);
            if validationFitness > maximumValidationFitness
                maximumValidationFitness = validationFitness;
                bestValidationChromosome = chromosome;
            end
        end
    end
    fprintf('Generation %d. Maximum fitness is %.2f, maximum validation fitness is %.2f.\n',...
        iGeneration, maximumFitness, maximumValidationFitness);
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
        mutatedChromosome = Mutate(originalChromosome, weightRange, ...
            ordinaryMutationProbability, creepMutationProbability, creepRate);
        tempPopulation(i,:) = mutatedChromosome;
    end
    tempPopulation = InsertBestIndividual(tempPopulation, ...
        population(bestIndividualIndex,:), elitismCopies);
    population = tempPopulation;    
end

%% Plot and display output
hold on
plot(validationFitnessArray);
plot(fitnessArray);
xlabel('Generation','interpreter','latex')
ylabel('Fitness','intepreter','latex')

chromosome = bestValidationChromosome;
fprintf('Training fitness = %.2f, validation fitness = %.2f, test fitness = %.2f.\n', ...
    GetFitness(chromosome, numberOfHiddenNeurons, slopeLength, 1),...
    GetFitness(chromosome, numberOfHiddenNeurons, slopeLength, 2),...
    GetFitness(chromosome, numberOfHiddenNeurons, slopeLength, 3))

