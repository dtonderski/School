function iterates = NewtonRaphson(coefficients, startingPoint, tolerance)
    
    oldValue = startingPoint;
    
    firstDerivative = Polynomial(oldValue, PolynomialDifferentiation(coefficients, 1));
    secondDerivativeCoefficients = PolynomialDifferentiation(coefficients, 2);
    secondDerivative = Polynomial(oldValue, secondDerivativeCoefficients);
    
    if isempty(secondDerivativeCoefficients)
        error("The degree of the polynomial must be 2 or larger!")
    end
    if secondDerivative == 0
        error("The second derivative is zero!")
    end
    
    newValue = NewtonRaphsonStep(oldValue, firstDerivative, secondDerivative);
    iterates = [oldValue newValue];

        
    
    while(abs(newValue - oldValue) >= tolerance)
        oldValue = newValue;
        firstDerivativeCoefficients = PolynomialDifferentiation(coefficients, 1);
        firstDerivative = Polynomial(oldValue, firstDerivativeCoefficients);
        secondDerivativeCoefficients = PolynomialDifferentiation(coefficients, 2);
        secondDerivative = Polynomial(oldValue, secondDerivativeCoefficients);

        if isempty(secondDerivativeCoefficients)
            error("The degree of the polynomial must be 2 or larger!")
        end
        if secondDerivative == 0
            error("The second derivative is zero!")
        end
        newValue = NewtonRaphsonStep(oldValue, firstDerivative, secondDerivative);
        iterates = [iterates, newValue];
    end    
  

end
