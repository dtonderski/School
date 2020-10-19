%% Initialization
clear; clc;
%% Load and convert data to the desired format
[xTrain, tTrain, xValid, tValid, xTest, tTest] = LoadMNIST(3);
imageSize = [28 28 1];

[~, idxTrain] = max(tTrain);
tTrain = categorical(idxTrain);
xTrain = uint8(reshape(xTrain, [imageSize size(xTrain,2)])*255);

[~, idxValid] = max(tValid);
tValid = categorical(idxValid);
xValid = uint8(reshape(xValid, [imageSize size(xValid,2)])*255);

[~, idxTest] = max(tTest);
tTest = categorical(idxTest);
xTest = uint8(reshape(xTest, [imageSize size(xTest,2)])*255);


%% Network 1
layers1 = [
    imageInputLayer([28 28 1])
    convolution2dLayer(5, 20, 'Stride', 1, 'Padding', 1, 'WeightsInitializer', 'narrow-normal');
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2);
    fullyConnectedLayer(100, 'WeightsInitializer', 'narrow-normal')
    reluLayer
    fullyConnectedLayer(10, 'WeightsInitializer', 'narrow-normal')
    softmaxLayer
    classificationLayer];

options1 = trainingOptions('sgdm', ...
    'Momentum', 0.9, ...
    'MaxEpochs', 60, ...
    'MiniBatchSize', 8192, ...
    'InitialLearnRate',0.001, ...
    'ValidationPatience', 5, ...
    'ValidationFrequency', 30, ...
    'Shuffle', 'every-epoch', ...
    'ValidationData', {xValid, tValid}, ...
    'Plots','training-progress');


net1 = trainNetwork(xTrain, tTrain, layers1, options1); 
%% Test network 1
[trainAccuracy, validAccuracy, testAccuracy] = testNetwork(net1, xTrain, tTrain, xValid, tValid, xTest, tTest);
fprintf('Network 1 results: training accuracy = %.4f, validation accuracy = %.4f, and test accuracy = %.4f.\n', ...
    trainAccuracy, validAccuracy, testAccuracy);

%% Network 2

%% Functions
function [trainAccuracy, validAccuracy, testAccuracy] = testNetwork(network, xTrain, tTrain, xValid, tValid, xTest, tTest)
    yTrain = classify(network, xTrain)';
    trainAccuracy = sum(tTrain == yTrain)/numel(yTrain);

    yValid = classify(network, xValid)';
    validAccuracy = sum(tValid == yValid)/numel(yValid);

    yTest = classify(network, xTest)';
    testAccuracy = sum(tTest == yTest)/numel(yTest);
end