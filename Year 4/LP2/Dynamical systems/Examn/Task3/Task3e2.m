clear all
load('pointData.mat')
N_points = 512;
x_start = linspace(-5,5,N_points);
y_start = linspace(-5,5,N_points);
[X,Y] = meshgrid(x_start,y_start);

pointDataWithoutEdges = pointData(2:N_points-1, 2:N_points-1);
edgeDataSmall = pointData(2:N_points-1, 2:N_points-1) - pointData(3:N_points, 2:N_points-1) + ...
           pointData(2:N_points-1, 2:N_points-1) - pointData(1:N_points-2, 2:N_points-1) + ...
           pointData(2:N_points-1, 2:N_points-1) - pointData(1:N_points-2, 3:N_points) + ...
           pointData(2:N_points-1, 2:N_points-1) - pointData(1:N_points-2, 1:N_points-2);
edgeDataSmall(edgeDataSmall~=0) = 1;
edgeData = zeros(N_points);
edgeData(2:N_points-1, 2:N_points-1) = edgeDataSmall;

surf(X,Y,edgeData)
shading interp

save('edgeData.mat', 'edgeData')