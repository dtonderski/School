function y = GetSigmoid(x)
    y = 1 ./ (1 + exp(-x));
end