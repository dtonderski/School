[XTrain,YTrain] = digitTrain4DArrayData;
imageSize = [28 28 1];


layers = [
    imageInputLayer(imageSize)
    convolution2dLayer(5, 20, 'Stride', 4, 'Padding', 1, 'WeightsInitializer', 'narrow-normal');
    reluLayer   
    maxPooling2dLayer(2,'Stride',2)
    
    fullyConnectedLayer(100, 'WeightsInitializer', 'narrow-normal')
    reluLayer
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];

opts = trainingOptions('sgdm', ...
    'MaxEpochs',100, ...
    'Shuffle','every-epoch', ...
    'Plots','training-progress', ...
    'Verbose',false);

net = trainNetwork(XTrain, YTrain,layers,opts);
