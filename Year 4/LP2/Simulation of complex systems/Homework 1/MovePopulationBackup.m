function [susceptible, infected, recovered, susceptibleLattice] = MovePopulationBackup(susceptible, infected, recovered, susceptibleLattice, diffusionRate, xRange, yRange)
if ~isempty(susceptible)
    [susceptible, susceptibleLattice, movedAgents] = Move(susceptible, susceptibleLattice, diffusionRate, true);
    susceptible = Clip(susceptible, xRange, yRange);
    for j = movedAgents
        x = susceptible(j, 1);
        y = susceptible(j, 2);
        susceptibleLattice(x, y).susceptibleAgents = [susceptibleLattice(x, y).susceptibleAgents, j];
    end
end

if ~isempty(infected)
    infected = Move(infected, diffusionRate, false);
    infected = Clip(infected, xRange, yRange);
end

if ~isempty(recovered)
    recovered = Move(recovered, diffusionRate, false);
    recovered = Clip(recovered, xRange, yRange);
end

end

function [population, susceptibleLattice, movedAgents] = Move(population, susceptibleLattice, diffusionRate, susceptibleBoolean)
    movedAgents = [];
    for i = 1:size(population, 1)
        if rand < diffusionRate
            movedAgents = [movedAgents, i];
            coordinates = population(i,:);
            if susceptibleBoolean
                currentAgents = susceptibleLattice(coordinates(1), coordinates(2)).susceptibleAgents;
                currentAgents(currentAgents == i) = [];
                susceptibleLattice(coordinates(1), coordinates(2)).susceptibleAgents = currentAgents;
            end
            coordinateToMove = randi([1 2]);
            population(i, coordinateToMove) = coordinates(coordinateToMove) + (randi([0 1])*2 - 1); 
        end
    end
end

function population = Clip(population, xRange, yRange)
    population(population(:,1) == xRange(1) - 1,1) = population(population(:,1) == xRange(1) - 1,1) + 2;
    population(population(:,1) == xRange(2) + 1,1) = population(population(:,1) == xRange(2) + 1,1) - 2;

    population(population(:,2) == xRange(1) - 1,2) = population(population(:,2) == xRange(1) - 1,2) + 2;
    population(population(:,2) == yRange(2) + 1,2) = population(population(:,2) == yRange(2) + 1,2) - 2;
end