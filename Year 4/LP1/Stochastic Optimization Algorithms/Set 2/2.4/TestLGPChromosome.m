constants = [1,3,10];
numberOfRegisters = 4;
divisionByZeroResult = 1e10;
maxChromosomeLength = 160;

bestChromosome = [1;2;3;1;3;2;1;3;1;2;3;1;4;1;6;1;4;1;6;1;1;2;3;1;1;2;3;1;3;3;6;2;1;1;2;5;1;1;2;5;3;2;1;3;1;1;2;5;1;1;2;5;1;1;2;5;4;1;6;1;3;2;1;3;1;2;3;1;1;2;3;1;1;1;2;5;4;1;6;1;1;2;3;1;4;1;6;1;4;1;6;1;3;2;1;3;1;1;2;5;4;1;6;1;4;1;6;1;3;2;1;3;1;2;3;1;4;1;6;1;1;2;3;1;3;3;6;2;1;1;2;5;4;1;6;1;3;2;1;3;1;2;3;1;1;2;3;1;1;2;3;1;1;2;3;1;1;2;3;1];
functionData = LoadFunctionData;

xData = functionData(:,1);
yData = functionData(:,2);
dataLength = length(xData);
yEstimate = zeros(dataLength, 1);
for i = 1:dataLength
    yEstimate(i) = DecodeChromosome(xData(i), bestChromosome, constants, numberOfRegisters, divisionByZeroResult);
end
clf
plot(xData,yData)
hold on
plot(xData,yEstimate)
xlabel('x', 'interpreter','latex')
ylabel('y', 'interpreter','latex')

syms x
eq = simplify(DecodeChromosome(x, bestChromosome, constants, numberOfRegisters, divisionByZeroResult));
legend('Data','Estimate')
fprintf('The estimated g(x) is %s with an error of %.4f.\n', eq, 1/GetFitness(bestChromosome,constants,numberOfRegisters,divisionByZeroResult, maxChromosomeLength));