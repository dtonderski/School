%% Network 1 - yeast
network = LoadNetwork1();

[averagePath,diameter] = GetAveragePathLength(network);
clusteringCoefficient = GetClusteringCoefficient(network);

%%
figure(1)
subplot(1,3,1)
ShowGraph(network)
title(sprintf('Network 1, average path = %.6f, diameter = %d, clustering coefficient = %.6f', averagePath, diameter, clusteringCoefficient), 'interpreter', 'latex');


subplot(1,3,2)
[kArray, PArray] = GetPArray(network, 20);
loglog(kArray, PArray)
xlabel('k')
ylabel('P(k)')
axis equal
title('Network 1, degree distribution', 'interpreter', 'latex');



subplot(1,3,3)
CDF = GetCDF(PArray, kArray);
loglog(1-CDF, kArray)
xlabel('p')
ylabel('ICCDD(p)')
axis equal
title('Network 1, ICCDD', 'interpreter', 'latex');

%% Network 2 - social network
network = LoadNetwork2();

[averagePath,diameter] = GetAveragePathLength(network);
clusteringCoefficient = GetClusteringCoefficient(network);
%%
figure(2)
subplot(1,3,1)
ShowGraph(network)
title(sprintf('Network 2, average path = %.6f, diameter = %d, clustering coefficient = %.6f', averagePath, diameter, clusteringCoefficient), 'interpreter', 'latex');


subplot(1,3,2)
[kArray, PArray] = GetPArray(network, 20);
loglog(kArray, PArray)
xlabel('k')
ylabel('P(k)')
axis equal
title('Network 2, degree distribution', 'interpreter', 'latex');



subplot(1,3,3)
CDF = GetCDF(PArray, kArray);
loglog(1-CDF, kArray)
xlabel('p')
ylabel('ICCDD(p)')
axis equal
title('Network 2, ICCDD', 'interpreter', 'latex');

%% Network 3 - power grid
network = LoadNetwork3();

[averagePath,diameter] = GetAveragePathLength(network);
clusteringCoefficient = GetClusteringCoefficient(network);
%%
figure(3)
clf
subplot(1,3,1)
ShowGraph(network)
title(sprintf('Network 3, average path = %.6f, diameter = %d, clustering coefficient = %.6f', averagePath, diameter, clusteringCoefficient), 'interpreter', 'latex');


subplot(1,3,2)

[kArray, PArray] = GetPArray(network, 20);
loglog(kArray, PArray)
xlabel('k')
ylabel('P(k)')
axis equal
title('Network 3, degree distribution', 'interpreter', 'latex');



subplot(1,3,3)
CDF = GetCDF(PArray, kArray);
loglog(1-CDF, kArray)
xlabel('p')
ylabel('ICCDD(p)')
axis equal
title('Network 3, ICCDD', 'interpreter', 'latex');