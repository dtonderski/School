function fitness = GetFitness(chromosome, constants, numberOfRegisters, divisionByZeroResult, maxLength)
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

if chromosomeLength > maxLength
    fitness = fitness / exp((chromosomeLength-maxLength)/200);
end
    
end

