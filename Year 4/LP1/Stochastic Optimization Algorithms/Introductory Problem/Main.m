polynomialCoefficients = [10 -2 -1 1]; % Defines the polynomial 10 - 2x - x^2 + x^3
polynomialCoefficients = [0 -1 -0.5 0 0.25];

startingPoint = 1;
tolerance = 1e-10;
iterationValues = NewtonRaphson(polynomialCoefficients, startingPoint, tolerance);
PlotIterations(polynomialCoefficients,iterationValues);
