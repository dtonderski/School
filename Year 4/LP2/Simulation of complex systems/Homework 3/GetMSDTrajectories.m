function [MSDMatrix, tauArray] = GetMSDTrajectories(xTrajectories, yTrajectories, nParticles, dt, timeStep)
tauMax = timeStep - 1;
MSDMatrix = zeros(tauMax, nParticles);
tauArray = 1:tauMax;
for tau = tauArray
    xDisplacements = xTrajectories(1+tau:end,:) - xTrajectories(1:end-tau,:);
    yDisplacements = yTrajectories(1+tau:end,:) - yTrajectories(1:end-tau,:);
    MSDMatrix(tau, :)       = mean(xDisplacements.^2 + yDisplacements.^2, 1);
end
tauArray = tauArray*dt;
end