clear, clc
xMax = 10;
yMax = 10;
xRange = [1 xMax];
yRange = [1 yMax];
nAgents = 1;
diffusionRate = 0.8;
infectedProportion = 0.1;
timeSteps = 100;

xPositions = zeros(1,timeSteps);
yPositions = zeros(1,timeSteps);

[susceptible, infected, recovered] = InitializePopulation(nAgents, infectedProportion, xRange, yRange);
for t = 1:timeSteps
    [susceptible, infected, recovered]  = MovePopulation(susceptible, infected, recovered, diffusionRate, xRange, yRange);
    xPositions(t) = susceptible(1);
    yPositions(t) = susceptible(2);
    %pause(0.1)
    %PlotPopulation(susceptible, infected, recovered,xRange,yRange);
end
clf
plot(xPositions, yPositions);
xlabel('x', 'Interpreter', 'latex')
ylabel('y', 'Interpreter', 'latex')
title('$d = 0.8, t = 100$', 'Interpreter', 'latex')
xlim([1 10])
ylim([1 10])
