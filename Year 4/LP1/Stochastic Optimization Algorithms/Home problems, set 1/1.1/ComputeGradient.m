function gradient = ComputeGradient(x1, x2, mu)
    gradient = [2*(x1-1); 4*(x2-2)];

    if x1^2 + x2^2 - 1 > 0
        gradient = gradient + [4*mu*x1*(x1.^2 + x2.^2 - 1); ...
            4*mu*x2*(x1.^2 + x2.^2 - 1)];
    end
end

