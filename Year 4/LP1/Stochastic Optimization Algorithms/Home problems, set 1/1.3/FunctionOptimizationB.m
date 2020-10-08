clear all; clc; clf
INF = 1e100;
populationSize = 100;
numberOfGenes = 50;
crossoverProbability = 0.8;
pTournament = 0.75;
tournamentSize = 2;
variableRange = 10;
numberOfGenerations = 100;
numberOfVariables = 2;
elitismCopies = 1;

mutationProbabilityArray = [0, 0.02, 0.05, 0.1];
medianFitnessArray = [0, 0, 0, 0];
numberOfRuns = 100;



for iMutation = 1:length(mutationProbabilityArray)
    mutationProbability = mutationProbabilityArray(iMutation);
    disp(mutationProbability)
    fitnessArray = zeros(1, numberOfRuns);
    for iRun = 1:numberOfRuns
        fitness = zeros(populationSize,1);
        population = InitializePopulation(populationSize, numberOfGenes);
        for iGeneration = 1:numberOfGenerations
            maximumFitness = 0;
            xBest = zeros(1, numberOfVariables);
            bestIndividualIndex = 0;
            for i = 1:populationSize
                chromosome = population(i,:);
                x = DecodeChromosome(chromosome, numberOfVariables, variableRange);
                fitness(i) = EvaluateIndividual(x);
                if fitness(i) > maximumFitness
                    maximumFitness = fitness(i);
                    bestIndividualIndex = i;
                    xBest = x;
                end
            end

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
                mutatedChromosome = Mutate(originalChromosome, mutationProbability);
                tempPopulation(i,:) = mutatedChromosome;
            end

            tempPopulation = InsertBestIndividual(tempPopulation, population(bestIndividualIndex,:), elitismCopies);
            population = tempPopulation;    
        end
        fitnessArray(iRun) = maximumFitness;
    end
    medianFitnessArray(iMutation) = median(fitnessArray);
end

disp('Mutation probabilities:')
disp(mutationProbabilityArray)
disp('Median fitness values')
disp(medianFitnessArray)
