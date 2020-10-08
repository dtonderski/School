function newChromosomePair = Cross(chromosome1,chromosome2)
nGenes = size(chromosome1,2);

%nGenes+1 because we want Cross to be able to switch the two chromosomes
crossoverPoint = randi([1,nGenes+1]);

newChromosomePair = [chromosome1;chromosome2];

newChromosomePair(1, crossoverPoint:end) = chromosome2(crossoverPoint:end);
newChromosomePair(2, crossoverPoint:end) = chromosome1(crossoverPoint:end);

end

