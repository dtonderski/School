function position = InitializePositions(xmax, xmin, NParticles)
nVariables = length(xmin);
position = zeros(NParticles,nVariables);
for jVariable = 1:nVariables
    min = xmin(jVariable);
    max = xmax(jVariable);
    r = rand(1,NParticles);
    position(:,jVariable) = min+r.*(max-min);
end
end

