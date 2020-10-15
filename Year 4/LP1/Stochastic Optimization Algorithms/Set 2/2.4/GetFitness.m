function fitness = GetFitness(chromosome, constants, numberOfRegisters, divisionByZeroResult, maxChromosomeLength)
functionData = LoadFunctionData;
numberOfDataPoints = size(functionData, 1);
errorSum = 0;
for iDataPoint = 1:numberOfDataPoints
    input = functionData(iDataPoint, 1);
    targetOutput = functionData(iDataPoint, 2);
    estimate = DecodeChromosome(input, chromosome, constants, numberOfRegisters, divisionByZeroResult);
    errorSum = errorSum + (estimate - targetOutput)^2;
end
error = sqrt(errorSum/numberOfDataPoints);
fitness = 1/error;
chromosomeLength = length(chromosome);

if chromosomeLength > maxChromosomeLength
    fitness = fitness / exp((chromosomeLength-maxChromosomeLength)/100);
end
    
end

