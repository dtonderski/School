%% Initialization
clear; clc;
%% Load and convert data to the desired format
[xTrain, tTrain, xValid, tValid, xTest, tTest] = LoadMNIST(1);

%% Autoencoder 1
layers1 = [
    sequenceInputLayer(784)
    
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
    'Shuffle', 'every-epoch', ...
    'MaxEpochs', 800, ...
    'Plots','training-progress');

[net1, trainingInfo1] = trainNetwork(xTrain, xTrain, layers1, options);

%% Autoencoder 2
layers2 = [
    sequenceInputLayer(784)
    
    fullyConnectedLayer(50, 'WeightsInitializer', 'glorot')
    reluLayer
    
    fullyConnectedLayer(4, 'WeightsInitializer', 'glorot')
    reluLayer
    
    fullyConnectedLayer(784, 'WeightsInitializer', 'glorot')
    reluLayer
    
    regressionLayer];

[net2, trainingInfo2] = trainNetwork(xTrain, xTrain, layers2, options); 
%%
save('Homework3_2_networks.mat', 'net1', 'trainingInfo1', 'net2', 'trainingInfo2')
%% Test network 1
for iImage = 1:50
    imageData = xTrain(:,iImage);
    
    subplot(1,2,1)
    image = reshape(imageData, 28, 28, 1);
    imshow(image);
    
    subplot(1,2,2)
    predictedImageData = predict(net1, imageData);
    predictedImage = reshape(predictedImageData, 28, 28, 1);
    imshow(predictedImage);
    a = iImage;
    pause(1);
end
%% Test network 2
for iImage = 1:50
    imageData = xTrain(:,iImage);
    
    subplot(1,2,1)
    image = reshape(imageData, 28, 28, 1);
    imshow(image);
    
    subplot(1,2,2)
    predictedImageData = predict(net2, imageData);
    predictedImage = reshape(predictedImageData, 28, 28, 1);
    imshow(predictedImage);
    a = iImage;
    pause(1);
end
    
%% Divide network
net1_layers_encode(1:5) = [net1.Layers(1:4); regressionLayer];
net1_layers_decode(1:5) = [sequenceInputLayer(2); net1.Layers(5:8)];
net1_encode = assembleNetwork(net1_layers_encode);
net1_decode = assembleNetwork(net1_layers_decode);

net2_layers_encode(1:5) = [net2.Layers(1:4); regressionLayer];
net2_layers_decode(1:5) = [sequenceInputLayer(4); net2.Layers(5:8)];
net2_encode = assembleNetwork(net2_layers_encode);
net2_decode = assembleNetwork(net2_layers_decode);





