function nextArgument = NewtonRaphsonStep(argument, firstDerivative, secondDerivative)

nextArgument = argument - firstDerivative./secondDerivative;

end

