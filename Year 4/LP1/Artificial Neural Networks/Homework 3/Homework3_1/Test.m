%%
testImage = randi([1 5000]);
imshow(XTrain(:,:,1,testImage))
disp(YTrain(testImage))

%%
[xTrain1, tTrain1, xValid1, tValid1, xTest1, tTest1] = LoadMNIST(3);

%%
[xTrain, tTrain, xValid, tValid, xTest, tTest] = LoadMNIST(1);
imageSize = [28 28 1];

[~, idxTrain] = max(tTrain);
tTrain = categorical(idxTrain);
xTrain = reshape(xTrain, [imageSize size(xTrain,2)]);

[~, idxValid] = max(tValid);
tValid = categorical(idxValid);
xValid = reshape(xValid, [imageSize size(xValid,2)]);

[~, idxTest] = max(tTest);
tTest = categorical(idxTest);
xTest = reshape(xTest, [imageSize size(xTest,2)]);

%%
format long
xTrain(15,15,1)
xTrain1(15,15,1,1)