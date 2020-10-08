function drawCube()
    allEdges = getAllEdges(3);
    numberOfEdges = size(allEdges,1);
    for edge = 1:numberOfEdges
        hold on
        plot3([allEdges(edge,1), allEdges(edge,4)], ...
              [allEdges(edge,2), allEdges(edge,5)], ...
              [allEdges(edge,3), allEdges(edge,6)], 'black')
    end
end