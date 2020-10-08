clear, clc, close all

startingPoint = [1;2];
stepLength = 0.0001;
threshold = 1e-6;
muSequence = [1,10,100,1000];
numberOfDigitsToShow = 3;

tableData = zeros(length(muSequence), 3);

for iMu = 1:length(muSequence)
    mu = muSequence(iMu);
    xStar = RunGradientDescent(startingPoint,mu,stepLength,threshold);
    tableData(iMu, :) = [mu, xStar(1), xStar(2)];
end

VarNames = {'mu', 'x1*', 'x2*'};
%Rounds the data to the number of digits specified in numberOfDigitsToShow
tableData = round(tableData,numberOfDigitsToShow);
T = table(tableData(:,1), tableData(:,2), tableData(:,3), 'VariableNames', VarNames);
format short
disp(T)