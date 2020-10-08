function population = InitializePopulation(populationSize,nGenes, initialWeightRange)

r = rand(populationSize, nGenes);
population = -initialWeightRange + 2*r*initialWeightRange;

end

