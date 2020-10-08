function mutatedChromosome = Mutate(chromosome, mutationProbability, creepRate)

nGenes = size(chromosome, 2);
mutatedChromosome = chromosome;
for i = 1:nGenes
    r = rand;
    if r < mutationProbability
        q = rand;
        mutatedChromosome(i) = chromosome(i) - creepRate/2 + creepRate*q;
    end
end
end

