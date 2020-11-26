clear
xRange = [-100, 100];
yRange = [-100, 100];
vRange = [1 2];

radius = 1; 
nParticles = 4;
nStatic = 0;
diffusionTrans = 10;
diffusionRot = 10;
dt = 1e-2;
timeSteps = 5000;
torqueConstant = 0;
bounceOfWalls = true;
repeats = 100;


[xParticles, yParticles, vParticles, phiParticles] = InitializeParticles(xRange,yRange, vRange,nParticles, radius, repeats);

[xTrajectories,yTrajectories] = InitializeTrajectories(xParticles,yParticles, nParticles, timeSteps);
[xStatic, yStatic] = InitializeStaticParticles(xRange, yRange, nStatic, radius, repeats);

for t = 1:timeSteps
    [xParticles, yParticles, phiParticles] = GetParticleNext2(xParticles, yParticles, vParticles, phiParticles, diffusionTrans, diffusionRot, torqueConstant, dt, bounceOfWalls, xRange, yRange);
    [xParticles, yParticles] = AvoidOverlap(xParticles, yParticles, radius, repeats);
    
    xTrajectories(t,:) = xParticles;
    yTrajectories(t,:) = yParticles;
%     figure(1)
%     clf
%     PlotTrajectories(xTrajectories,yTrajectories, nParticles, xStatic, yStatic, t, xRange, yRange, false)
%     pause(0.001)

end
figure(1)
clf
PlotTrajectories(xTrajectories,yTrajectories, nParticles, xStatic, yStatic, t, xRange, yRange, true)


figure(2)
clf
PlotTrajectories(xTrajectories,yTrajectories, nParticles, xStatic, yStatic, t, xRange, yRange, true)

[MSDMatrix, tauArray] = GetMSDTrajectories(xTrajectories, yTrajectories, nParticles, dt, timeSteps);
figure(2)
clf
PlotMSDTrajectories(MSDMatrix, tauArray, nParticles)