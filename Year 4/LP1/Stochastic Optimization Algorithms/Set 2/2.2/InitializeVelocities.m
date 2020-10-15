function velocity = InitializeVelocities(rangeMin, rangeMax, alpha, deltat, nParticles)
nVariables = length(rangeMin);
velocity = zeros(nParticles,nVariables);
for jVariable = 1:nVariables
    min = rangeMin(jVariable);
    max = rangeMax(jVariable);
    r = rand(1,nParticles);
    velocity(:,jVariable) = alpha/deltat*(-(max-min)/2 + r.*(max-min));
end
end