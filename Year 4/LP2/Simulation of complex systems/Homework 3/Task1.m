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
xParticles = [-50 -50 50 50];
yParticles = [-50 50 -50 50];
vParticles = [0 1 2 3];
    
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

[MSDMatrix, tauArray] = GetMSDTrajectories(xTrajectories, yTrajectories, nParticles, dt, timeSteps);

figure(1)
clf
hold on
for i = 1:nParticles
    p(i) = plot(xTrajectories(t, i), yTrajectories(t, i), 'o', 'MarkerSize', 4);
    plot(xTrajectories(1:t, i), yTrajectories(1:t,i), 'Color', p(i).Color);
    strings{i} = sprintf(' v = %d ', vParticles(i));
end
title(sprintf('$D_T = %d, D_R = %d$', diffusionTrans, diffusionRot), 'interpreter', 'latex')
legend(p, char(strings(1)), char(strings(2)), char(strings(3)), char(strings(4)))

xlim(xRange)
ylim(yRange)

figure(2)
clf

for i = 1:nParticles
    p1(i) = loglog(tauArray, MSDMatrix(1:end,i), 'Color', p(i).Color);
    if i == 1
        hold on
    end
end
title(sprintf('$D_T = %d, D_R = %d$', diffusionTrans, diffusionRot), 'interpreter', 'latex')

legend(p1, char(strings(1)), char(strings(2)), char(strings(3)), char(strings(4)), 'location', 'northwest')
xlabel('$\tau$', 'interpreter', 'latex')
ylabel('MSD' , 'interpreter', 'latex')