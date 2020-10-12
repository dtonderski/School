function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    N = size(visibility,1);
    path = randi([1 N]);
    while length(path)<N
        path = [path GetNode(path, pheromoneLevel,visibility,alpha,beta)];
    end
end

