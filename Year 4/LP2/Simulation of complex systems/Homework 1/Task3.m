clear, clc
xMax = 100;
yMax = 100;
xRange = [1 xMax];
yRange = [1 yMax];
nAgents = 1000;
diffusionRate = 1;
infectedProportion = 0.01;
numberOfRuns = 10;
maxRatio = 100;
numberOfPoints = 30;

%%
beta1 = 0.9;
gammaRange1 = beta1./linspace(0,maxRatio,numberOfPoints);
recoveredProportion1 = zeros(size(gammaRange1));

for iGamma = 1:length(gammaRange1)
    disp(iGamma)
    gamma = gammaRange1(iGamma);
    
    recoveredProportionRun = zeros(1, numberOfRuns);
    for iRun = 1:numberOfRuns
        [susceptible, infected, recovered] = InitializePopulation(nAgents, infectedProportion, xRange, yRange);
        while ~isempty(infected)
            [susceptible, infected, recovered]  = MovePopulation(susceptible, infected, recovered, diffusionRate, xRange, yRange);
            susceptibleLattice                  = GetSusceptibleLattice(susceptible, xMax, yMax);
            [susceptible, infected]             = Infect(susceptible, infected, susceptibleLattice, beta1);
            [infected, recovered]               = Recover(infected, recovered, gamma);
        end
        recoveredProportionRun(iRun) = size(recovered,1) / nAgents;
    end
    recoveredProportion1(iGamma) = mean(recoveredProportionRun);
end
%%
beta2 = 0.1;
gammaRange2 = beta2./linspace(0,maxRatio, numberOfPoints);
recoveredProportion2 = zeros(size(gammaRange2));

for iGamma = 1:length(gammaRange2)
    disp(iGamma)
    gamma = gammaRange2(iGamma);
    
    recoveredProportionRun = zeros(1, numberOfRuns);
    for iRun = 1:numberOfRuns
        [susceptible, infected, recovered] = InitializePopulation(nAgents, infectedProportion, xRange, yRange);
        susceptibleLattice                  = GetSusceptibleLattice(susceptible, xMax, yMax);
        while ~isempty(infected)
            [susceptible, infected, recovered]  = MovePopulation(susceptible, infected, recovered, diffusionRate, xRange, yRange);
            susceptibleLattice                  = GetSusceptibleLattice(susceptible, xMax, yMax);
            [susceptible, infected]             = Infect(susceptible, infected, susceptibleLattice, beta2);
            [infected, recovered]               = Recover(infected, recovered, gamma);
        end
        recoveredProportionRun(iRun) = size(recovered,1) / nAgents;
    end
    recoveredProportion2(iGamma) = mean(recoveredProportionRun);
end
%%
clf
clear
load('3.mat')
plot(beta1./gammaRange1, recoveredProportion1)
hold on
plot(beta2./gammaRange2, recoveredProportion2)
legend('$\beta = 0.9$', '$\beta = 0.1$', 'Interpreter', 'latex');
xlabel('$k = \beta/\gamma$', 'Interpreter', 'latex');
ylabel('$R_\infty$', 'Interpreter', 'latex');
title('1000 agents, 100 by 100 lattice, d = 1, 10 runs per point', 'Interpreter', 'latex');


