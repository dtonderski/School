function ShowForest(treeLocations, fireLocations)
clf
hold on
if ~isempty(treeLocations)
    scatter(treeLocations(:,1), treeLocations(:,2), '.g')
end
if ~isempty(fireLocations)
    scatter(fireLocations(:,1), fireLocations(:,2), [], [255,140,0]/255, '.')
end
xlim([0 128])
ylim([0 128])

end

