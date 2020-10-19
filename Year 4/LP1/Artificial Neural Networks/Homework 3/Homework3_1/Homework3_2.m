%% Initialization
clear; clc;
%% Load and convert data to the desired format
[xTrain, tTrain, xValid, tValid, xTest, tTest] = LoadMNIST(3);
imageSize = [28 28 1];
xTrain = double(reshape(xTrain, imageSize(1)*imageSize(2), size(xTrain, 4)))/255;
xValid = double(reshape(xValid, imageSize(1)*imageSize(2), size(xValid, 4)))/255;
xTest  = double(reshape(xTest , imageSize(1)*imageSize(2), size(xTest , 4)))/255;

%% Autoencoder 1
layers1 = [
    sequenceInputLayer(imageSize)
    
    fullyConnectedLayer(50, 'WeightsInitializer', 'glorot')
    reluLayer
    
    fullyConnectedLayer(2, 'WeightsInitializer', 'glorot')
    reluLayer
    
    fullyConnectedLayer(784, 'WeightsInitializer', 'glorot')
    reluLayer
    
    regressionLayer];

options = trainingOptions('adam', ...
    'MiniBatchSize', 8192, ...
    'InitialLearnRate',0.001, ...
    