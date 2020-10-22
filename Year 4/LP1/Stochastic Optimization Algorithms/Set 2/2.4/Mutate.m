function mutatedChromosome = Mutate(chromosome, mutationProbability, numberOfRegisters, numberOfConstants)

numberOfOperands = numberOfRegisters + numberOfConstants;
chromosomeLength = length(chromosome);
mutatedChromosome = chromosome;

for i = 1:chromosomeLength
    r = rand;
    
    if r < mutationProbability
        if mod(1,4) == 1
            mutatedChromosome(i) = randi([1 4]);
        elseif mod(1,4) == 2
            mutatedChromosome(i) = randi([1 numberOfRegisters]);
        else
            mutatedChromosome(i) = randi([1 numberOfOperands]);
        end
    end
end
end

