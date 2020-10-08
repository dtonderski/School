%% GetSlopeAngle
temp = [1, 2, 3; 10, 5, 5];
x = 1:0.1:1000;
alphamax = 10;
for i = 1:3
    iDataSet = temp(1, i);
    iSlope = temp(2,i);
    angle = GetSlopeAngle(x,iSlope,iDataSet);
    assert(max(angle)<alphamax, strcat(['Slope ', num2str(iSlope), ...
        ', data set ', num2str(iDataSet), ' has a too big angle!']));
end
    