%% Initialization
clear all; close all; clc;
%% Parameters
rangeMin = [-5,-5];
rangeMax = [5,5];
nParticles = 20;
deltat = 1;
alpha = 1;
vmax = (rangeMax(1) - rangeMin(1))/deltat;
c1 = 2;
c2 = 2;
w = 1.4;
wLower = 0.3;
tol = 1e-10;
numberOfRuns = 30;

%% Find minima
for iRun = 1:numberOfRuns

    position = InitializePositions(rangeMin, rangeMax, nParticles);
    velocity = InitializeVelocities(rangeMin,rangeMax,alpha,deltat,nParticles);
    performance = EvaluateParticle(position);
    particleBestPosition = position;
    particleBestPerformance = performance;

    [~, currentBestPositionIndex] = min(performance);
    globalBestPosition = position(currentBestPositionIndex,:);
    globalBestPerformance = performance(currentBestPositionIndex);
    flag = 0;

    while true
        velocity = UpdateVelocities(velocity,position,c1,c2,deltat,...
            particleBestPosition,globalBestPosition, w);
        velocity(velocity>vmax) = vmax;
        position = position+velocity*deltat;
        performance = EvaluateParticle(position);
        for i = 1:nParticles
            if performance(i) < particleBestPerformance(i)
                particleBestPosition(i,:) = position(i,:);
                particleBestPerformance(i) = performance(i);
                if performance(i) < globalBestPerformance
                    if norm(particleBestPosition(i,:) - globalBestPosition) < tol
                        globalBestPosition = position(i,:);
                        globalBestPerformance = performance(i);
                        flag = 1;
                        break
                    end
                    globalBestPosition = position(i,:);
                    globalBestPerformance = performance(i);
                end
            end
        end
        if flag == 1
            break
        end
        if w > wLower
            w = w - 0.1;
        end
    end
%     fprintf('In run %d, the minimum (x,y) = (%.6f,%.6f) was found.\n',...
%         iRun, globalBestPosition(1), globalBestPosition(2));
    globalBestPosition = round(globalBestPosition,6);
    if iRun == 1
        minima = globalBestPosition;
    else
        % Only add position to minima if it isn't already there
        minima = union(minima, globalBestPosition, 'rows');
    end
end

%% Plot minima
x = linspace(-5,5);
y = linspace(-5,5);
[X,Y] = meshgrid(x,y);
Z = (X.^2+Y-11).^2 + (X+Y.^2-7).^2;
contour(X,Y,log(0.01 + Z));
hold on

for iMinimum = 1:length(minima)
    plot(minima(iMinimum,1), minima(iMinimum,2), 'xr', 'MarkerSize', 10)
end

hold off
