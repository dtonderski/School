function mutatedChromosome = Mutate(chromosome, mutationProbability, numberOfRegisters, numberOfConstants)
% Looping over each gene of every chromosome would be very slow.
% Therefore, a different approach is used. First, the number of mutated
% genes is drawn for each type of gene. There are four types of genes, so
% the numbers are called k1, k2, k3, k4. They are drawn out of a binomial
% distribution with n = chromosomeLength/4 and p = mutationProbability.
% For the first type of gene, k1 numbers are then drawn randomly from the 
% range 1:chromosomeLength/4. From these, 1 is subtracted, they are 
% multiplied by 4, and then 1 is added. The results are the indices of the
% gene to be mutated, which is then done according to the rules for
% that gene type (for the first gene type, the values have to be in the
% range 1:4). This is then repeated for each gene type.
%
% The reason for this complexity is that each gene mutates according to
% different rules. Implementing this efficiently seemed to require complex
% code.

numberOfOperands = numberOfRegisters + numberOfConstants;
chromosomeLength = length(chromosome);
n = chromosomeLength/4;
p = mutationProbability;
r = binornd(n, p, 1, 4);

mutatedChromosome = chromosome;
for iGeneType = 1:4
    numberOfMutatedGenes = r(iGeneType);
    if iGeneType == 1
        mutatedGeneIndices = (randperm(n, numberOfMutatedGenes)-1)*4+1;
        newGeneValues = randi([1 4], numberOfMutatedGenes, 1);
    elseif iGeneType == 2
        mutatedGeneIndices = (randperm(n, numberOfMutatedGenes)-1)*4+2;
        newGeneValues = randi([1 numberOfRegisters], numberOfMutatedGenes, 1);
    elseif iGeneType == 3
        mutatedGeneIndices = (randperm(n, numberOfMutatedGenes)-1)*4+3;
        newGeneValues = randi([1 numberOfOperands], numberOfMutatedGenes, 1);
    elseif iGeneType == 4
        mutatedGeneIndices = (randperm(n, numberOfMutatedGenes)-1)*4+4;
        newGeneValues = randi([1 numberOfOperands], numberOfMutatedGenes, 1);
    end
    mutatedChromosome(mutatedGeneIndices) = newGeneValues;
end
end

