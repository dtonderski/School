function differentiatedCoefficients = PolynomialDifferentiation(inputCoefficients, derivativeOrder)
% Function that returns the coefficients of a differentiated polynomial
polynomialDegree = length(inputCoefficients)-1;

differentiatedPolynomialDegree = polynomialDegree - derivativeOrder;

differentiatedCoefficients = zeros(1,differentiatedPolynomialDegree + 1);

for i=0:differentiatedPolynomialDegree
    % Iterates over the degrees in the differentiated polynomial. First,
    % the factor that comes from the differentiation is calculated, and 
    % then it is multiplied by the coefficient from the original polynomial
    
    coefficientFromDifferentiation = factorial(i + derivativeOrder)/...
        factorial(i);
    
    differentiatedCoefficients(i+1) = coefficientFromDifferentiation*...
        inputCoefficients(i+1+derivativeOrder);
end


end

