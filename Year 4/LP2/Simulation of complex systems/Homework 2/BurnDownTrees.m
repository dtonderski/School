function [forest, fireLocations] = BurnDownTrees(forest)
    fireLocations = double.empty(0,2);
    treesToBurn = forest == 2;
    forest(treesToBurn) = 0;   
end