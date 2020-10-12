function mutatedChromosome = Mutate(chromosome, weightRange, ...
    ordinaryMutationProbability, creepMutationProbability, creepRate)

nGenes = size(chromosome, 2);
mutatedChromosome = chromosome;
for i = 1:nGenes
    r = rand;
    if r < creepMutationProbability
        q = rand;
        mutatedChromosome(i) = chromosome(i) - creepRate/2 + creepRate*q;
    end
    r = rand;
    if r < ordinaryMutationProbability
        q = rand;
        mutatedChromosome(i) = -weightRange + 2*q*weightRange;
    end
end
end

