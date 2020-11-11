function PlotPopulation(susceptible, infected, recovered, xRange, yRange)
clf
hold on
if ~isempty(susceptible)
    scatter(susceptible(:,1), susceptible(:,2), 'blue.')
end

if ~isempty(infected)
    scatter(infected(:,1), infected(:,2), 'r.')
end

if ~isempty(recovered)
    scatter(recovered(:,1), recovered(:,2), 'g.')
end

xlim(xRange);
ylim(yRange);
end

