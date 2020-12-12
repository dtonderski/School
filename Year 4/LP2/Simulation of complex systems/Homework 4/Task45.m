clear
M = LoadSmallWorldExample();
coeff = round(GetClusteringCoefficient(M),6);
ShowGraph(M)
[averagePathLength, diameter] = GetAveragePathLength(M);

title(sprintf('Clustering coefficient = %.6f, average path = %.5f, diameter = %d.', coeff, averagePathLength, diameter), 'interpreter', 'latex')
