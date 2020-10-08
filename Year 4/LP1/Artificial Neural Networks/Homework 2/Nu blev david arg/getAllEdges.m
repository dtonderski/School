function allEdges = getAllEdges(nDims)
numberOfEdges = nDims*2^(nDims-1);
start = zeros(1, nDims);
allEdges = zeros(numberOfEdges, nDims*2);

currentIndex = 1;
previousEnd = 0;

for i = 1:nDims
    stop = start;
    stop(i) = 1;
    allEdges(currentIndex,:) = [start, stop];
    currentIndex = currentIndex + 1;
end

while currentIndex < numberOfEdges
    previousStart = previousEnd+1;
    previousEnd = currentIndex;

    for i = previousStart:previousEnd
        start = allEdges(i,nDims+1:2*nDims);
        for j = 1:nDims
            stop = start;
            if stop(j) == 1
                continue
            else
                stop(j) = 1;
                if any(ismember(allEdges, [start, stop], 'rows'))
                    continue
                else
                    allEdges(currentIndex,:) = [start, stop];
                    currentIndex = currentIndex + 1;
                end
            end
        end
    end
end
end

