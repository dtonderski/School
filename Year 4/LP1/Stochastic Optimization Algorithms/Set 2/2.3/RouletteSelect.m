function iSelected = RouletteSelect(fitness)
    populationSize = length(fitness);
    theta = zeros(populationSize,1);
    for i = 1:populationSize
        theta(i) = sum(fitness(1:i));
    end
    theta = theta/sum(fitness);
    r = rand;
    for i = 1:populationSize
        if theta(i) > r
            iSelected = i;
            return
        end
    end
end

