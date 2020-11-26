clear
xRange = [-100, 100];
yRange = [-100, 100];
vRange = [1 5];

radius = 1;
nParticles = 100;
nStatic = 0;
diffusionTrans = 10;
diffusionRot = 10;
dt = 1e-3;
timeSteps = 10000;
torqueConstant = 100;
bounceOfWalls = true;
repeats = 5;


[xParticles, yParticles, vParticles, phiParticles] = InitializeParticles(xRange,yRange, vRange,nParticles, radius, repeats);
[xTrajectories,yTrajectories] = InitializeTrajectories(xParticles,yParticles, nParticles, timeSteps);
[xStatic, yStatic] = InitializeStaticParticles(xRange, yRange, nStatic, radius, repeats);

f = figure(1);
F(timeSteps) = getframe(gcf);
tic
for t = 1:timeSteps
    if mod(t, timeSteps/100) == 0
        fprintf('%d %% done.\n', round(t/timeSteps*100));
    end
    [xParticles, yParticles, phiParticles] = GetParticleNext2(xParticles, yParticles, vParticles, phiParticles, diffusionTrans, diffusionRot, torqueConstant, dt, bounceOfWalls, xRange, yRange);
    [xParticles, yParticles] = AvoidOverlap(xParticles, yParticles, radius, repeats);  
    
    xTrajectories(t,:) = xParticles;
    yTrajectories(t,:) = yParticles;
    f = figure(1);
    clf
    PlotTrajectories2(xTrajectories,yTrajectories, nParticles, xStatic, yStatic, radius, t, xRange, yRange, false)    
    title(sprintf('$v_{mean} = %d, D_T = %d, D_R = %d, T_0 = %d$, %d particles, $t = %.3f$',...
        mean(vRange), diffusionTrans, diffusionRot, torqueConstant, nParticles, t*dt), 'interpreter', 'latex')
    F(t) = getframe(gcf);
end
toc
% figure(2)
% clf
% PlotTrajectories(xTrajectories,yTrajectories, nParticles, xStatic, yStatic, t, xRange, yRange, false)


writerObj = VideoWriter('myVideo.avi');
writerObj.FrameRate = round(1/dt);
open(writerObj);
for i=1:length(F)
    frame = F(i) ;    
    writeVideo(writerObj, frame);
end
close(writerObj);