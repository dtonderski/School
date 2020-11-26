syms sigma x(t) y(t)
tmin = 0;
tmax = 10;

MVar = [ sigma+3, 4; -9/4, sigma-3 ];
sigma = -1;
M = eval(MVar);
Y = [x;y];
odes = diff(Y) == M*Y;
[xSol(t), ySol(t)] = dsolve(odes)
C = Y(0) == [0.1,0.1];
[xSol(t), ySol(t)] = dsolve(odes,C)
clf

fplot(xSol, ySol, [0 10])