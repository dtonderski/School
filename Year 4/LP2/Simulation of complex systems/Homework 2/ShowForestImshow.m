function ShowForest(forest)
newForestR = zeros(size(forest));
newForestR(forest == 0) = 1;
newForestR(forest == 1) = 0;
newForestR(forest == 2) = 1;

newForestG = zeros(size(forest));
newForestG(forest == 0) = 1;
newForestG(forest == 1) = 1;
newForestG(forest == 2) = 0;

newForestB = zeros(size(forest));
newForestB(forest == 0) = 1;
newForestB(forest == 1) = 0;
newForestB(forest == 2) = 0;

newForest = zeros([size(forest), 3]);
newForest(:,:,1) = newForestR;
newForest(:,:,2) = newForestG;
newForest(:,:,3) = newForestB;

imshow(newForest, 'InitialMagnification',300)
end

