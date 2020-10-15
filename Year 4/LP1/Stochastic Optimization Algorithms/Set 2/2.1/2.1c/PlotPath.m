function PlotPath(connection, cityLocation, path)

numberOfCities = length(cityLocation);
for i = 1:(numberOfCities-1)
   set(connection(i),'XData',[cityLocation(path(i),1) cityLocation(path(i+1),1)]);
   set(connection(i),'YData',[cityLocation(path(i),2) cityLocation(path(i+1),2)]);
end
set(connection(numberOfCities),'XData',[cityLocation(path(numberOfCities),1) cityLocation(path(1),1)]);
set(connection(numberOfCities),'YData',[cityLocation(path(numberOfCities),2) cityLocation(path(1),2)]);

drawnow;