function susceptibleLattice = GetSusceptibleLattice(susceptible, xMax, yMax)
susceptibleLattice(xMax, yMax) = struct('susceptibleAgents', []);
for j = 1:size(susceptible,1)
    x = susceptible(j, 1);
    y = susceptible(j, 2);
    susceptibleLattice(x, y).susceptibleAgents = [susceptibleLattice(x, y).susceptibleAgents, j];
end
end

