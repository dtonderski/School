clear, clf
cityLocations = LoadCityLocations;
INF = 1e100;
populationSize = 100;
N = size(cityLocations, 1);
mutationProbability = 0.02;
numberOfGenerations = 10000;
elitismCopies = 2;

population = InitializePopulation(populationSize, N);
fitness = zeros(populationSize,1);

bestFitnessArray = zeros(1, numberOfGenerations);
meanFitnessArray = zeros(1, numberOfGenerations);
tic
for iGeneration = 1:numberOfGenerations
    for i = 1:populationSize
        chromosome = population(i,:);
        fitness(i) = EvaluateIndividual(chromosome,cityLocations);
    end
    [maximumFitness, bestIndividualIndex] = max(fitness);
    bestFitnessArray(iGeneration) = maximumFitness;
    meanFitnessArray(iGeneration) = mean(fitness);
    tempPopulation = population;

    for i = 1:populationSize
        originalChromosome = tempPopulation(i,:);
        mutatedChromosome = Mutate(originalChromosome, mutationProbability);
        tempPopulation(i,:) = mutatedChromosome;
    end

    tempPopulation = InsertBestIndividual(tempPopulation, ...
        population(bestIndividualIndex,:), elitismCopies);
    population = tempPopulation;
    
end
toc
plot(bestFitnessArray);
hold on
plot(meanFitnessArray);
disp(maximumFitness);