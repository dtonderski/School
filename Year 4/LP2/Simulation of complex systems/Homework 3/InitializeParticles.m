function  [xParticles, yParticles, vParticles, phiParticles] = InitializeParticles(xRange, yRange, vRange, nParticles, radius, repeats)
xParticles = rand(1,nParticles)*(xRange(end) - xRange(1)) + xRange(1);
yParticles = rand(1,nParticles)*(yRange(end) - yRange(1)) + yRange(1);
vParticles = rand(1,nParticles)*(vRange(end) - vRange(1)) + vRange(1);
phiParticles = rand(1,nParticles)*2*pi;
[xParticles, yParticles] = AvoidOverlap(xParticles, yParticles, radius, repeats);
end