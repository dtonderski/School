clear all; clc;
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
numberOfRuns = 20;
slopeLength = 1000;

pTournament = 0.9;
tournamentSize = 2;


bestRunValidationFitnessArray = zeros(numberOfRuns, 1);
bestRunValidationChromosomeArray = zeros(numberOfRuns, numberOfGenes);


for iRun = 1:numberOfRuns
    fitness = zeros(populationSize,1);
    population = InitializePopulation(populationSize, numberOfGenes, weightRange);

    validationFitness = zeros(populationSize, 1);
    maximumValidationFitness = -INF;
    bestRunValidationFitness = -INF;

    fitnessArray = [];
    validationFitnessArray = [];
    
    for iGeneration = 1:numberOfGenerations
        maximumFitness = -INF;
        maximumValidationFitness = -INF;
        for i = 1:populationSize
            chromosome = population(i,:);
            fitness(i) = GetTrainingFitness(chromosome, numberOfHiddenNeurons, slopeLength);
            if fitness(i) > maximumFitness
                maximumFitness = fitness(i);
                bestIndividualIndex = i;
                bestChromosome = chromosome;
                validationFitness = GetValidationFitness(chromosome,numberOfHiddenNeurons, 2);
                if validationFitness > maximumValidationFitness
                    maximumValidationFitness = validationFitness;
                    if validationFitness > bestRunValidationFitness
                        bestRunValidationFitness = validationFitness;
                        bestRunValidationChromosome = chromosome;
                    end
                end
            end
        end
        fprintf('Run %d, generation %d. Maximum fitness is %.4f, maximum validation fitness is %.4f.\n', iRun, iGeneration, maximumFitness, maximumValidationFitness);
        fitnessArray = [fitnessArray, maximumFitness];
        validationFitnessArray = [validationFitnessArray, maximumValidationFitness];
        tempPopulation = population;

        for i = 1:2:populationSize
            i1 = TournamentSelect(fitness, pTournament, tournamentSize);
            i2 = TournamentSelect(fitness, pTournament, tournamentSize);
            %i1 = RouletteSelect(fitness);
            %i2 = RouletteSelect(fitness);
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
    figure(iRun);
    clf
    hold on
    plot(validationFitnessArray);
    plot(fitnessArray);
    bestRunValidationFitnessArray(iRun) = bestRunValidationFitness;
    bestRunValidationChromosomeArray(iRun, :) = bestRunValidationChromosome;
    
end

%%
for i = 1:iRun
    chromosome = bestRunValidationChromosomeArray(i, :);
    sprintf('i = %d, 1 = %.4f, 2 = %.4f, 3 = %.4f', i, ...
        GetValidationFitness(chromosome, numberOfHiddenNeurons, 1), GetValidationFitness(chromosome, numberOfHiddenNeurons, 2),...
        GetValidationFitness(chromosome, numberOfHiddenNeurons, 3))
end