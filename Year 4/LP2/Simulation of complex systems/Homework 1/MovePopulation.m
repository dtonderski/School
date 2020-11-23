function [susceptible, infected, recovered] = MovePopulation(susceptible, infected, recovered, diffusionRate, xRange, yRange)
if ~isempty(susceptible)
    susceptible = Move(susceptible, diffusionRate);
    susceptible = Clip(susceptible, xRange, yRange);
end

if ~isempty(infected)
    infected = Move(infected, diffusionRate);
    infected = Clip(infected, xRange, yRange);
end

if ~isempty(recovered)
    recovered = Move(recovered, diffusionRate);
    recovered = Clip(recovered, xRange, yRange);
end

end

function [population] = Move(population, diffusionRate)
    for i = 1:size(population, 1)
        if rand < diffusionRate
            coordinateToMove = randi([1 2]);
            population(i, coordinateToMove) = population(i, coordinateToMove) + (randi([0 1])*2 - 1); 
        end
    end
end

function population = Clip(population, xRange, yRange)
    population(population(:,1) == xRange(1) - 1,1) = population(population(:,1) == xRange(1) - 1,1) + 2;
    population(population(:,1) == xRange(2) + 1,1) = population(population(:,1) == xRange(2) + 1,1) - 2;

    population(population(:,2) == xRange(1) - 1,2) = population(population(:,2) == xRange(1) - 1,2) + 2;
    population(population(:,2) == yRange(2) + 1,2) = population(population(:,2) == yRange(2) + 1,2) - 2;
end