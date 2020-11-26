function [xParticles, yParticles] = AvoidOverlap(xParticles, yParticles, radius, repeats)
for j = 1:repeats
    xDir = (xParticles-xParticles');
    yDir = (yParticles-yParticles');
    r = sqrt(xDir.^2 + yDir.^2);
    xHatDir = xDir ./ r;
    yHatDir = yDir ./ r;
    [rowIndices, colIndices] = find(r < 2*radius);
    indices = rowIndices ~= colIndices;
    rowIndices = rowIndices(indices);
    colIndices = colIndices(indices);

    for i = 1:length(rowIndices)
        row = rowIndices(i);
        col = colIndices(i);
        xParticles(row) = xParticles(row) - (2*radius*xHatDir(row, col) + 0.001 - xDir(row,col))/2;
        yParticles(row) = yParticles(row) - (2*radius*yHatDir(row, col) + 0.001 - yDir(row,col))/2;
    end
    if isempty(rowIndices)
        break
    end
end
end

