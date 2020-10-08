function x = DecodeChromosome(chromosome,numberOfVariables, variableRange)
chromosomeLength = size(chromosome,2);
if mod(chromosomeLength, numberOfVariables) ~= 0
    error("Chromosome length isn't divisible by number of variables!")
end

bitsPerChromosome = chromosomeLength / numberOfVariables;
x = zeros(1,numberOfVariables);

for i = 1:numberOfVariables
    startBitNumber = 1 + bitsPerChromosome*(i-1);
    endBitNumber = bitsPerChromosome*i;
    currentBit = chromosome(startBitNumber:endBitNumber);
    
    for j = 1:bitsPerChromosome
        x(i) = x(i) + currentBit(j)*2^(-j);
    end
end

x = -variableRange + 2*variableRange.*x/(1-2^(-bitsPerChromosome));
end

