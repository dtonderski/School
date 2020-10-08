function fitness = EvaluateIndividual(x)
x1 = x(1);
x2 = x(2);

g11 = (x1+x2+1);
g12 = (19-14*x1+3*x1.^2-14*x2+6*x1*x2+3*x2^2);
g1 = (1+g11^2*g12);

g21 = (2*x1 - 3*x2);
g22 = (18-32*x1+12*x1.^2+48*x2-36*x1.*x2+27*x2.^2);
g2 = (30+g21.^2.*g22);
g = g1*g2;

fitness = 1/g;



end

