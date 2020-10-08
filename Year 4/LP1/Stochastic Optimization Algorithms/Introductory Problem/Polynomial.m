function value = Polynomial(argument, polynomialCoefficients)

    value = 0;
    if isempty(polynomialCoefficients)
        value = 0;
        return
    end
    for i = 1:length(polynomialCoefficients)
        value = value + argument.^(i-1).* polynomialCoefficients(i);
    end

end

