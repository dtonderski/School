function fitness = GetTrainingFitness(chromosome, numberOfHiddenNeurons, slopeLength)
fitnessArray = [];
iDataSet = 1;
for iSlope = 1:10
        [xArray, vArray] = DriveTruck(chromosome, numberOfHiddenNeurons, iSlope, iDataSet);
        fitness = xArray(end);
        if xArray(end) == slopeLength
            fitness = fitness*mean(vArray);
        end
        fitnessArray = [fitnessArray, fitness];
end
fitness = min(fitnessArray);
end
