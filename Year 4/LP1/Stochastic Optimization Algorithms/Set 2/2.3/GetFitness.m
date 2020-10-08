function fitness = GetFitness(chromosome, NH, iDataSet)
fitnessArray = [];
if iDataSet == 1
    for iSlope = 1:10
        [xArray, vArray] = DriveTruck(chromosome, NH, iSlope, iDataSet);
        fitness = xArray(end)*mean(vArray);
        fitnessArray = [fitnessArray, fitness];
    end
else
    for iSlope = 1:5
        [xArray, vArray] = DriveTruck(chromosome, NH, iSlope, iDataSet);
        fitness = xArray(end)*mean(vArray);
        fitnessArray = [fitnessArray, fitness];
    end
end
fitness = min(fitnessArray);
end
