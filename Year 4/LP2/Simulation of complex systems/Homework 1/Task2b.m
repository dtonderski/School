clear, clc
xMax = 100;
yMax = 100;
xRange = [1 xMax];
yRange = [1 yMax];
nAgents = 1000;
diffusionRate = 0.8;
infectedProportion = 0.01;
beta = 0.5;
gamma = 0.015;

susceptibleArray  = [];
infectedArray     = [];
recoveredArray    = [];

[susceptible, infected, recovered] = InitializePopulation(nAgents, infectedProportion, xRange, yRange);
while ~isempty(infected)
    [susceptible, infected, recovered]  = MovePopulation(susceptible, infected, recovered, diffusionRate, xRange, yRange);
    susceptibleLattice                  = GetSusceptibleLattice(susceptible, xMax, yMax);
    [susceptible, infected]             = Infect(susceptible, infected, susceptibleLattice, beta);
    [infected, recovered]               = Recover(infected, recovered, gamma);
    susceptibleArray = [susceptibleArray, size(susceptible, 1)];
    infectedArray    = [infectedArray, size(infected, 1)];
    recoveredArray   = [recoveredArray, size(recovered  , 1)];
end
figure(1)
clf
PlotPopulation(susceptible,infected,recovered,xRange,yRange);
xlabel('x', 'Interpreter', 'latex')
ylabel('y', 'Interpreter', 'latex')
title('$d = 0.8, \beta = 0.6, \gamma = 0.015$, 1000 agents', 'Interpreter', 'latex')

figure(2)
clf
hold on
plot(susceptibleArray, 'blue');
plot(infectedArray, 'red');
plot(recoveredArray, 'green');
xlabel('Time steps', 'Interpreter', 'latex');
ylabel('Number of agents', 'Interpreter', 'latex');
title('$d = 0.8, \beta = 0.6, \gamma = 0.015$', 'Interpreter', 'latex');
legend('Susceptible', 'Infected', 'Recovered', 'Interpreter', 'latex');

