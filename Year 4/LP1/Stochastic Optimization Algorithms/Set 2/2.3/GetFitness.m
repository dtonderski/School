function fitness = GetFitness(chromosome, numberOfHiddenNeurons, slopeLength, iDataSet)
fitnessArray = [];
if iDataSet == 1
    for iSlope = 1:10
        [xArray, vArray] = DriveTruck(chromosome, numberOfHiddenNeurons, iSlope, iDataSet);
        fitness = xArray(end);
        if xArray(end) == slopeLength
            fitness = fitness*mean(vArray);
        end
        fitnessArray = [fitnessArray, fitness];
    end
else
    for iSlope = 1:5
        [xArray, vArray] = DriveTruck(chromosome, numberOfHiddenNeurons, iSlope, iDataSet);
        fitness = xArray(end);
        if xArray(end) == slopeLength
            fitness = fitness*mean(vArray);
        end
        fitnessArray = [fitnessArray, fitness];
    end
end
fitness = min(fitnessArray);
end
