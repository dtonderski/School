function velocity = InitializeVelocities(xmin, xmax, alpha, deltat, NParticles)
nVariables = length(xmin);
velocity = zeros(NParticles,nVariables);
for jVariable = 1:nVariables
    min = xmin(jVariable);
    max = xmax(jVariable);
    r = rand(1,NParticles);
    velocity(:,jVariable) = alpha/deltat*(-(max-min)/2 + r.*(max-min));
end
end