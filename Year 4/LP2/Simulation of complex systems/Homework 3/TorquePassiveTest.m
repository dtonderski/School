nParticles = 3;
nStatic = 2;
diffusionTrans = 0.2;
diffusionRot = 0.2;
dt = 1;
timeSteps = 20;
torqueConstant = 200;
bounceOfWalls = true;


[xParticles, yParticles, vParticles, phiParticles] = InitializeParticles(xRange,yRange, vRange,nParticles);
[xTrajectories,yTrajectories] = InitializeTrajectories(xParticles,yParticles, nParticles, timeSteps);
[xStatic, yStatic] = InitializeStaticParticles(xRange, yRange, nStatic);
