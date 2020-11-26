function [xTrajectories,yTrajectories] = InitializeTrajectories(xParticles,yParticles, nParticles, timeSteps)
xTrajectories = zeros(timeSteps, nParticles);
xTrajectories(1,:) = xParticles;
yTrajectories = zeros(timeSteps, nParticles);
yTrajectories(1,:) = yParticles;
end

