function nextNode = GetNode(path, pheromoneLevel,visibility,alpha,beta)
N = size(visibility,1);
possibleNodes = setdiff(1:N, path);
j = path(end);
M = length(possibleNodes);
theta = zeros(M, 1);
% Here, temp corresponds to the fitness in other roulette selection
% algorithms (F in equation 3.13).
temp = zeros(M,1);
for jTheta = 1:M
    l = possibleNodes(jTheta);
    temp(jTheta) = pheromoneLevel(l,j)^alpha*visibility(l,j).^beta;
end

for jTheta = 1:M
    theta(jTheta) = sum(temp(1:jTheta));
end
theta = theta/sum(temp);

r = rand;
for jTheta = 1:M
    if theta(jTheta) > r
        nextNode = possibleNodes(jTheta);
        return
    end
end

end

