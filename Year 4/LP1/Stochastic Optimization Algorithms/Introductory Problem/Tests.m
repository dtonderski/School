%% PolynomialDifferentiation tests
for testIter = 1:1e2
    n = randi([0,10]);
    k = randi([0,10]);
    coeffs = randi([1,10],1,n);
    coeffsMatlab = flip(coeffs);

    newCoeffsMatlab = coeffsMatlab;
    for i = 1:k
        newCoeffsMatlab = polyder(newCoeffsMatlab);
    end

    newCoeffsMatlab = flip(newCoeffsMatlab);
    newCoeffs = PolynomialDifferentiation(coeffs,k);
    
    if isempty(newCoeffs)
        if newCoeffsMatlab~=0
            disp("WTF")
            break
        end
    else
        assert(isequal(newCoeffsMatlab, newCoeffs));
    end

end

