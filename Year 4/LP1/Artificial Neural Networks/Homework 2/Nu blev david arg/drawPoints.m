function drawPoints(pointData)
    hold on
    plot3(1,0,1,'o', 'color', 'black', 'MarkerFaceColor', [1,1,1]*pointData(1))
    plot3(0,0,1,'o', 'color', 'black', 'MarkerFaceColor', [1,1,1]*pointData(2))
    plot3(0,0,0,'o', 'color', 'black', 'MarkerFaceColor', [1,1,1]*pointData(3))    
    plot3(1,0,0,'o', 'color', 'black', 'MarkerFaceColor', [1,1,1]*pointData(4))
    plot3(1,1,1,'o', 'color', 'black', 'MarkerFaceColor', [1,1,1]*pointData(5))
    plot3(0,1,1,'o', 'color', 'black', 'MarkerFaceColor', [1,1,1]*pointData(6))
    plot3(0,1,0,'o', 'color', 'black', 'MarkerFaceColor', [1,1,1]*pointData(7))
    plot3(1,1,0,'o', 'color', 'black', 'MarkerFaceColor', [1,1,1]*pointData(8))
    
end