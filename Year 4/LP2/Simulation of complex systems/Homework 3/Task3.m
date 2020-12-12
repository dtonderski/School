clear
xRange = [-100, 100];
yRange = [-100, 100];
vRange = [1 5];

radius = 1;
nParticles = 100;
nStatic = 2000;
diffusionTrans = 100;
diffusionRot = 100;
dt = 0.01;
timeSteps = 100000;
torqueConstant = 20;
bounceOfWalls = true;
repeats = 5;
initialStaticRepeats = 100;

FPS = 100;
videoLength = 20;
speedUpFactor = videoLength / (timeSteps*dt);

nFrames = timeSteps*dt*FPS * speedUpFactor;
F(nFrames) = getframe(gcf);


[xParticles, yParticles, vParticles, phiParticles] = InitializeParticles(xRange,yRange, vRange,nParticles, radius, repeats);
[xTrajectories,yTrajectories] = InitializeTrajectories(xParticles,yParticles, nParticles, timeSteps);
[xStatic, yStatic] = InitializeStaticParticles(xRange, yRange, nStatic, radius, initialStaticRepeats);
[xParticles, yParticles] = AvoidOverlapWithPassive(xParticles, yParticles, xStatic, yStatic, radius, repeats);

f = figure(1);
F(nFrames) = getframe(gcf);
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
    
    if mod(t, timeSteps/nFrames) == 0
%         disp(t*nFrames/(timeSteps))
        f = figure(1);
        clf
        PlotTrajectories3(xTrajectories,yTrajectories, nParticles, xStatic, yStatic, nStatic, radius, t, xRange, yRange, false, true)
        title(sprintf('$v_{mean} = %d, D_T = %d, D_R = %d, T_0 = %d$, %d active, %d passive, $t = %.3f$',...
            mean(vRange), diffusionTrans, diffusionRot, torqueConstant, nParticles, nStatic, t*dt), 'interpreter', 'latex')
        F(t*nFrames/(timeSteps)) = getframe(gcf);
    end
end
toc
%%
figure(2)
clf
PlotTrajectories3(xTrajectories,yTrajectories, nParticles, xStatic, yStatic, nStatic, radius, t, xRange, yRange, true, true)
% save('task3.mat')


writerObj = VideoWriter(sprintf('Task3Videos/T0%dnStatic%d.avi', torqueConstant, nStatic));
writerObj.FrameRate = FPS;
open(writerObj);
for i=1:length(F)
    frame = F(i) ;    
    writeVideo(writerObj, frame);
end
close(writerObj);