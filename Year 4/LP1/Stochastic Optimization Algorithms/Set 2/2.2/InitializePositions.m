function position = InitializePositions(rangeMin, rangeMax, nParticles)
nVariables = length(rangeMin);
position = zeros(nParticles,nVariables);
for jVariable = 1:nVariables
    min = rangeMin(jVariable);
    max = rangeMax(jVariable);
    r = rand(1,nParticles);
    position(:,jVariable) = min+r.*(max-min);
end
end

