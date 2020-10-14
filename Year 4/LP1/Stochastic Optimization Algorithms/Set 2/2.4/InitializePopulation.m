function population = InitializePopulation(populationSize,minChromosomeLength,maxChromosomeLength,numberOfRegisters,numberOfConstants)
population = [];
numberOfOperands = numberOfRegisters + numberOfConstants;
for i = 1:populationSize
     chromosomeLength = minChromosomeLength + fix(rand*(maxChromosomeLength-minChromosomeLength+1));
     chromosomeLength = chromosomeLength - mod(chromosomeLength, 4);
     
     tmpChromosome = zeros(chromosomeLength, 1);
     % operators between 1 and 4
     tmpChromosome(1:4:end, :) = randi([1 4], chromosomeLength/4, 1);
     % destination registers between 1 and numberOfRegisters
     tmpChromosome(2:4:end, :) = randi([1 numberOfRegisters], chromosomeLength/4, 1);
     % operand registers between 1 and numberOfOperands
     tmpChromosome(3:4:end, :) = randi([1 numberOfOperands], chromosomeLength/4, 1);
     tmpChromosome(4:4:end, :) = randi([1 numberOfOperands], chromosomeLength/4, 1);
     
     tmpIndividual = struct('Chromosome',tmpChromosome);
     population = [population tmpIndividual];
end
end

