function [xStatic, yStatic] = InitializeStaticParticles(xRange, yRange, nStatic, radius, repeats)
xStatic = rand(1,nStatic)*(xRange(end) - xRange(1)) + xRange(1);
yStatic = rand(1,nStatic)*(yRange(end) - yRange(1)) + yRange(1);
[xStatic, yStatic] = AvoidOverlap(xStatic, yStatic, radius, repeats);
end

