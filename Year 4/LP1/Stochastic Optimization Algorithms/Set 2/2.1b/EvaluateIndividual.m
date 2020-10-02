function fitness = EvaluateIndividual(chromosome, cityLocation)
    N = length(chromosome);
    pathLength = 0;
    for i = 1:N-1
        start = cityLocation(chromosome(i),:);
        stop = cityLocation(chromosome(i+1),:);
        pathLength = pathLength + norm(start-stop);
    end
    start = cityLocation(chromosome(N),:);
    stop = cityLocation(chromosome(1),:);
    pathLength = pathLength + norm(start-stop);
    fitness = 1/pathLength;
end
