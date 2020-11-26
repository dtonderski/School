clear
xRange = [-100, 100];
yRange = [-100, 100];
vRange = [5 7];

radius = 1;
nParticles = 100;
nStatic = 2000;
diffusionTrans = 2;
diffusionRot = 1;
dt = 0.1;
timeSteps = 10000;
torqueConstant = 50;
bounceOfWalls = true;
repeats = 5;
initialStaticRepeats = 100;


[xParticles, yParticles, vParticles, phiParticles] = InitializeParticles(xRange,yRange, vRange,nParticles, radius, repeats);
[xTrajectories,yTrajectories] = InitializeTrajectories(xParticles,yParticles, nParticles, timeSteps);
[xStatic, yStatic] = InitializeStaticParticles(xRange, yRange, nStatic, radius, initialStaticRepeats);
%[xParticles, yParticles] = AvoidOverlapWithPassive(xParticles, yParticles, xStatic, yStatic, radius, 3);

f = figure(1);
for t = 1:timeSteps
    tic
    disp(t)
    [xParticles, yParticles, phiParticles] = GetParticleNext3(xParticles, yParticles, xStatic, yStatic, vParticles, phiParticles, diffusionTrans, diffusionRot, torqueConstant, dt, bounceOfWalls, xRange, yRange);
    xTrajectories(t,:) = xParticles;
    yTrajectories(t,:) = yParticles;
    [xParticles, yParticles] = AvoidOverlapWithPassive(xParticles, yParticles, xStatic, yStatic, radius, repeats);
    [xParticles, yParticles] = AvoidOverlap(xParticles, yParticles, radius, repeats);
    
    clf
    PlotTrajectories3(xTrajectories,yTrajectories, nParticles, xStatic, yStatic, nStatic, radius, t, xRange, yRange, false, true)
    title(sprintf('$D_T = %d, D_R = %d, T_0 = %d$, %d active, %d passive, t = %d',...
        diffusionTrans, diffusionRot, torqueConstant, nParticles, nStatic, t), 'interpreter', 'latex')
    shg;
    %exportgraphics(f, sprintf('task3images/%d.png', t), 'Resolution', 300)
    saveas(f, sprintf('task3images/%d.png', t))
    if mod(t,50) == 0
        figure(2)
        clf
        PlotTrajectories3(xTrajectories,yTrajectories, nParticles, xStatic, yStatic, nStatic, radius, t, xRange, yRange, true, true)
        shg
%         figure(3)
%         clf
%         PlotTrajectories3(xTrajectories,yTrajectories, nParticles, xStatic, yStatic, nStatic, radius, t, xRange, yRange, true, false)
        figure(1)
    end
    toc
end
%%
figure(2)
clf
PlotTrajectories3(xTrajectories,yTrajectories, nParticles, xStatic, yStatic, nStatic, radius, t, xRange, yRange, true, true)
save('task3.mat')