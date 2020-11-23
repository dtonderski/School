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
betaMin = 0.01;
betaMax = 0.99;

betaRange           = linspace(betaMin,betaMax,numberOfPoints);
kRange              = linspace(0,maxRatio,numberOfPoints);
[Beta, K]           = meshgrid(betaRange, kRange);
RecoveredProportion = zeros(length(betaRange), length(kRange));
tic
for iBeta = 1:length(betaRange)
    beta = betaRange(iBeta);
    for iK = 1:length(kRange)
        gamma = betaRange(iBeta)./kRange(iK);
        recoveredProportionRun = zeros(1, numberOfRuns);
        for iRun = 1:numberOfRuns
            fprintf('Beta is %.5f, gamma is %.5f, iRun is %d.\n', beta, gamma, iRun)
            [susceptible, infected, recovered] = InitializePopulation(nAgents, infectedProportion, xRange, yRange);
            while ~isempty(infected)
                [susceptible, infected, recovered]  = MovePopulation(susceptible, infected, recovered, diffusionRate, xRange, yRange);
                susceptibleLattice                  = GetSusceptibleLattice(susceptible, xMax, yMax);
                [susceptible, infected]             = Infect(susceptible, infected, susceptibleLattice, beta);
                [infected, recovered]               = Recover(infected, recovered, gamma);
            end
            recoveredProportionRun(iRun) = size(recovered,1) / nAgents;
        end
        RecoveredProportion(iBeta, iK) = mean(recoveredProportionRun);
        toc
    end
end
%%
clear
clf
load('4.mat')
surf(Beta,K,RecoveredProportion')
title('1000 agents, 100 by 100 lattice, d = 1, 10 runs per point', 'Interpreter', 'latex')
xlabel('$\beta$', 'Interpreter', 'latex')
ylabel('$k = \beta/\gamma$', 'Interpreter', 'latex')
zlabel('$R_\infty$', 'Interpreter', 'latex')