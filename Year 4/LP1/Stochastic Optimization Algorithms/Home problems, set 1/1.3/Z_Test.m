clc
fitness = [5,4,3,2,1]';
tournamentSize = 5;

testSize = 100000;
indices = zeros(1, testSize);
TournamentSelect(fitness, 0.5, tournamentSize)

%%
clc
TournamentSelect(fitness, 0.5, 2)

%%
x1 = xBestOverall(1);
x2 = xBestOverall(2);

g11 = (x1+x2+1);
g12 = (19-14*x1+3*x1.^2-14*x2+6*x1*x2+3*x2^2);
g1 = (1+g11^2*g12);

g21 = (2*x1 - 3*x2);
g22 = (18-32*x1+12*x1.^2+48*x2-36*x1.*x2+27*x2.^2);
g2 = (30+g21.^2.*g22);
g = g1*g2
