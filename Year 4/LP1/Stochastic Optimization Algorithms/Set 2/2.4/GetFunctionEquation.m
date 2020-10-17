function equationString = GetFunctionEquation(bestChromosome, constants, numberOfRegisters, divisionByZeroResult)
sympref('PolynomialDisplayStyle','ascend');
syms x;
eq = simplify(DecodeChromosome(x, bestChromosome, constants, numberOfRegisters, divisionByZeroResult));
equationString = string(eq);
% All this below was needed because Matlab for some reason changes the 
% order of the polynomial when using string(f), where f is a sym object.
slash_index = strfind(equationString, '/');
nominatorString = extractBetween(equationString, 1, slash_index-1);
denominatorString = extractBetween(equationString, slash_index+1, strlength(equationString));
nominator = str2sym(nominatorString);
denominator = str2sym(denominatorString);
nominatorString = evalc('disp(nominator)');
denominatorString = evalc('disp(denominator)');
nominatorString = extractBetween(nominatorString, 1, strlength(nominatorString)-3);
denominatorString = extractBetween(denominatorString, 1, strlength(denominatorString)-3);

equationString = sprintf('(%s)/(%s)', string(nominatorString), string(denominatorString));
end

