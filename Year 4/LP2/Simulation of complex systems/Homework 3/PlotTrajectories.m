function PlotTrajectories(xTrajectories,yTrajectories, nParticles, xStatic, yStatic, timeStep, xRange, yRange, showTrajectory)
hold on
for i = 1:nParticles
    p = plot(xTrajectories(timeStep, i), yTrajectories(timeStep, i), 'o', 'MarkerSize', 4);
    if showTrajectory
        plot(xTrajectories(1:timeStep, i), yTrajectories(1:timeStep,i), 'Color', p.Color);
    end
end

plot(xStatic, yStatic, 'o', 'Color', [128 128 128]/255, 'MarkerFaceColor', [220 220 220]/255, 'MarkerSize', 5)
plot(xStatic, yStatic, '.', 'Color', [1 1 1]/255, 'MarkerSize', 1)

xlim([min(min(min(xTrajectories)), xRange(1)), max(max(max(yTrajectories)), xRange(2))]);
ylim([min(min(min(xTrajectories)), yRange(1)), max(max(max(yTrajectories)), yRange(2))]);
xlim(xRange)
ylim(yRange)
xlabel('x')
ylabel('y')
hold off
end