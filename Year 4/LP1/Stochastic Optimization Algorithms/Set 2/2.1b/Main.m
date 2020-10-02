cityLocation = LoadCityLocations;
nCities = size(cityLocation,1);
path = randperm(nCities);                
tspFigure = InitializeTspPlot(cityLocation,[0 20 0 20]); 
connection = InitializeConnections(cityLocation); 
PlotPath(connection,cityLocation,path);
pause(2)
path = randperm(nCities);
PlotPath(connection,cityLocation,path);
