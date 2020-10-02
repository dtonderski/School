function population = InitializePopulation(populationSize,N)
population = zeros(populationSize, N);
for iRow = 1:populationSize
    population(iRow,:) = randperm(N);
end
end

