function [forest, treeLocations, fireLocations] = SimulateFires(forest, fireLocations)
while ~isempty(fireLocations)
    newFireLocations = [];
    for iTreeOnFire = 1:size(fireLocations,1)
        x = fireLocations(iTreeOnFire, 1);
        y = fireLocations(iTreeOnFire, 2);
        [forest, newFireLocations] = burnDownSurroundings(forest, newFireLocations, x, y);
    end
    fireLocations = newFireLocations;
end

[treeLocationsX, treeLocationsY] = find(forest == 1);
treeLocations = [treeLocationsX, treeLocationsY];

[fireLocationsX, fireLocationsY] = find(forest == 2);
fireLocations = [fireLocationsX, fireLocationsY];
end

function [forest, newFireLocations] = burnDownSurroundings(forest, newFireLocations, x, y)
    latticeSize = size(forest,1);
    if x < latticeSize && forest(x+1, y) == 1
        forest(x+1, y) = 2;
        newFireLocations = [newFireLocations; [x+1,y]];
    end
    if y < latticeSize && forest(x, y+1) == 1
        forest(x, y+1) = 2;
        newFireLocations = [newFireLocations; [x, y+1]];
    end
    if x > 1 && forest(x-1, y) == 1
        forest(x-1, y) = 2;
        newFireLocations = [newFireLocations; [x-1, y]];
    end
    if y > 1 && forest(x, y-1) == 1
        forest(x, y-1) = 2;
        newFireLocations = [newFireLocations; [x, y-1]];
    end        
end
