integrand = @(x,y) y.*sin(y+x.^2);
ymax = @(x) 1-x.^2;
integral2(integrand, -1, 1, 0, ymax)
