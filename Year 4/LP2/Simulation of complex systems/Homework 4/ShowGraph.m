function ShowGraph(M)
% n = size(M,1);
% angle = [2*pi/n:2*pi/n:2*pi]';
% XYCoords = [cos(angle), sin(angle)];
% gplot(M, XYCoords);
g = graph(M);
plot(g)

end

