function PlotIterations(polynomialCoefficients,iterationValues)

clf
minXValue = min(iterationValues);
maxXValue = max(iterationValues);

% Add 10% padding on the x-axis
paddingX = abs(maxXValue - minXValue).*0.1;

x = linspace(minXValue-paddingX, maxXValue+paddingX);
y = Polynomial(x, polynomialCoefficients);
plot(x,y)

iterationValuesY = Polynomial(iterationValues, polynomialCoefficients);

hold on
plot(iterationValues, iterationValuesY, 'o');

end

