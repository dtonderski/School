function mutatedChromosome = Mutate(chromosome, mutationProbability)
N = length(chromosome);
mutatedChromosome = chromosome;
for i = 1:N
    r = rand;
    if r < mutationProbability
        j = randi([1 N]);
        while j == i
            j = randi([1 N]);
        end
        tempGene = mutatedChromosome(j);
        mutatedChromosome(j) = mutatedChromosome(i);
        mutatedChromosome(i) = tempGene;
    end
end

