function [alphaArray, pedalPressureArray, gearArray, vArray, brakeTemperatureArray] = DriveTruckTest(chromosome, numberOfHiddenNeurons, iSlope, iDataSet)
% Constants
maxTemperature = 750;       % K
m = 20000;                  % kg
tau = 30;                   % s
cH = 40;                    % K/s
ambientTemperature = 283;   % K
cB = 3000;                  % N
vMax = 25;                  % m/s
vMin = 1;                   % m/s
alphaMax = 10;              % deg
g = 9.81;                   % m/s^2
dt = 0.25;                  % s
slopeLength = 1000;         % m

% Initialization
[w1, w2] = DecodeChromosome(chromosome,numberOfHiddenNeurons);
x = 0;                      % m
v = 20;                     % m/s
gear = 7;       
brakeTemperature = 500;     % K
t = 0;
alphaArray = [];
pedalPressureArray = [];
gearArray = [];
brakeTemperatureArray = [];
vArray = [];
timeSinceGearChange = -2;   %s

% Main loop
while x < slopeLength
    t = t+dt;
    
    alpha = GetSlopeAngle(x, iSlope, iDataSet);    
    deltaBrakeTemperature = brakeTemperature - ambientTemperature;
    
    input = [v/vMax; alpha/alphaMax; brakeTemperature/maxTemperature];
    [pedalPressure, DeltaGear] = GetNeuralNetworkOutput(input,w1,w2);    
    if t-timeSinceGearChange>=2
        if DeltaGear ~= 0
            timeSinceGearChange = t;
        end
        gear = gear + DeltaGear;
        if gear < 1
            gear = 1;
        elseif gear > 10
            gear = 10;
        end
    end
    
    alphaArray = [alphaArray, alpha];
    pedalPressureArray = [pedalPressureArray, pedalPressure];
    gearArray = [gearArray, gear];
    brakeTemperatureArray = [brakeTemperatureArray, brakeTemperature];
    vArray = [vArray, v];
    
    brakeTemperature = ambientTemperature + GetNextRelativeBrakeTemperature(deltaBrakeTemperature, tau, cH, pedalPressure, dt);
    gravityForce = GetGravityForce(alpha,m,g);
    brakingForce = GetBrakingForce(pedalPressure, brakeTemperature, maxTemperature, m, g);
    engineBrakingForce = GetEngineBrakingForce(cB, gear);
    if v>vMax || v<vMin
        break
    elseif brakeTemperature > maxTemperature
        break
    end
    [v,x] = GetNextVelocityAndPosition(v,x,gravityForce,brakingForce,engineBrakingForce,m,dt);
    vArray = [vArray, v];
end
if x < slopeLength
    disp('Did not finish the slope!')
end
end