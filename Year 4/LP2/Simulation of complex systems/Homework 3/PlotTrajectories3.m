function PlotTrajectories3(xTrajectories,yTrajectories, nParticles, xStatic, yStatic, nStatic, radius, timeStep, xRange, yRange, showTrajectory, showPassive)
hold on

viscircles([xTrajectories(timeStep, :)', yTrajectories(timeStep, :)'], ones(nParticles,1)*radius, 'Color', [255 64 64]/255);

if showTrajectory
    for i = 1:nParticles
            plot(xTrajectories(1:timeStep, i), yTrajectories(1:timeStep,i), 'Color', [255 64 64]/255);
    end
end


if showPassive
    %viscircles([xStatic', yStatic'], ones(nStatic,1)*radius, 'Color', [164 164 164]/255);
    plot(xStatic, yStatic, 'o', 'Color', [164 164 164]/255, 'MarkerFaceColor', [220 220 220]/255, 'MarkerSize', 7)
end
%plot(xStatic, yStatic, '.', 'Color', [1 1 1]/255, 'MarkerSize', 1)

xlim([min(min(min(xTrajectories)), xRange(1)), max(max(max(yTrajectories)), xRange(2))]);
ylim([min(min(min(xTrajectories)), yRange(1)), max(max(max(yTrajectories)), yRange(2))]);
xlim(xRange)
ylim(yRange)
xlabel('x')
ylabel('y')
hold off
end