clear
xRange = [-100, 100];
yRange = [-100, 100];
vRange = [5 7];

radius = 1;
nParticles = 100;
nStatic = 2000;
diffusionTrans = 1;
diffusionRot = 1;
dt = 0.1;
timeSteps = 10000;
torqueConstant = 50;
bounceOfWalls = true;
repeats = 5;
initialStaticRepeats = 100;
videoLength = 10;
speedUpFactor = videoLength / (timeSteps*dt);

[xParticles, yParticles, vParticles, phiParticles] = InitializeParticles(xRange,yRange, vRange,nParticles, radius, repeats);
[xTrajectories,yTrajectories] = InitializeTrajectories(xParticles,yParticles, nParticles, timeSteps);
[xStatic, yStatic] = InitializeStaticParticles(xRange, yRange, nStatic, radius, initialStaticRepeats);
[xParticles, yParticles] = AvoidOverlapWithPassive(xParticles, yParticles, xStatic, yStatic, radius, repeats);

f = figure(1);
F(timeSteps) = getframe(gcf);
tic
for t = 1:timeSteps
    if mod(t-1, timeSteps/100) == 0
        fprintf('%d %% done.\n', round((t-1)/timeSteps*100));
    end
    [xParticles, yParticles, phiParticles] = GetParticleNext3(xParticles, yParticles, xStatic, yStatic, vParticles, phiParticles, diffusionTrans, diffusionRot, torqueConstant, dt, bounceOfWalls, xRange, yRange);
    xTrajectories(t,:) = xParticles;
    yTrajectories(t,:) = yParticles;
    [xParticles, yParticles] = AvoidOverlapWithPassive(xParticles, yParticles, xStatic, yStatic, radius, repeats);
    [xParticles, yParticles] = AvoidOverlap(xParticles, yParticles, radius, repeats);
    
%     clf
%     PlotTrajectories3(xTrajectories,yTrajectories, nParticles, xStatic, yStatic, nStatic, radius, t, xRange, yRange, false, true)
%     title(sprintf('$v_{mean} = %d, D_T = %d, D_R = %d, T_0 = %d$, %d active, %d passive, $t = %.3f$',...
%         mean(vRange), diffusionTrans, diffusionRot, torqueConstant, nParticles, nStatic, t*dt), 'interpreter', 'latex')
%     F(t) = getframe(gcf);
end
toc
%%
figure(2)
clf
PlotTrajectories3(xTrajectories,yTrajectories, nParticles, xStatic, yStatic, nStatic, radius, t, xRange, yRange, true, true)
% save('task3.mat')