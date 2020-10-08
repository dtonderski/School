xmin = [-5,-5];
xmax = [5,5];
NParticles = 20;
deltat = 1;
alpha = 1;
%T = 10000;
vmax = (xmax(1) - xmin(1))/deltat;
c1 = 2;
c2 = 2;
w = 1.4;
wLower = 0.3;
tol = 1e-10;

position = InitializePositions(xmin, xmax, NParticles);
velocity = InitializeVelocities(xmin,xmax,alpha,deltat,NParticles);
performance = EvaluateParticle(position);
particleBestPosition = position;
particleBestPerformance = performance;

[~, currentBestPositionIndex] = min(performance);
globalBestPosition = position(currentBestPositionIndex,:);
globalBestPerformance = performance(currentBestPositionIndex);
t=0;
while globalBestPerformance > tol
    t=t+1;
    velocity = UpdateVelocities(velocity,position,c1,c2,deltat,...
        particleBestPosition,globalBestPosition, w);
    % Cut off velocities in both dimensions
    velocity(velocity>vmax) = vmax;
    position = position+velocity*deltat;
    performance = EvaluateParticle(position);
    for i = 1:NParticles
        if performance(i) < particleBestPerformance(i)
            particleBestPosition(i,:) = position(i,:);
            particleBestPerformance(i) = performance(i);
            if performance(i) < globalBestPerformance
                globalBestPosition = position(i,:);
                globalBestPerformance = performance(i);
            end
        end
    end
    if w > wLower
        w = w - 0.1;
    end
    pause(0.1)
    
end
disp(globalBestPerformance)
disp(globalBestPosition)