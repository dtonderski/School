function [xArray,vArray] = DriveTruckVisualize(chromosome, numberOfHiddenNeurons, iSlope, iDataSet)
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
x = 0;                      % m
v = 20;                     % m/s
gear = 7;       
brakeTemperature = 500;     % K
t = 0;
xArray = x;
vArray = v;
timeSinceGearChange = -2;   %s

% Main loop
[w1, w2] = DecodeChromosome(chromosome,numberOfHiddenNeurons);
while x < slopeLength
    disp(x)
    pause(0.1)    
    t = t+dt;
    alpha = GetSlopeAngle(x, iSlope, iDataSet);
    deltaBrakeTemperature = brakeTemperature - ambientTemperature;
    input = [v/vMax; alpha/alphaMax; brakeTemperature/maxTemperature];
    [pedalPressure, deltaGear] = GetNeuralNetworkOutput(input,w1,w2);
    if t-timeSinceGearChange>=2
        if deltaGear ~= 0
            timeSinceGearChange = t;
        end
        gear = gear + deltaGear;
        if gear < 1
            gear = 1;
        elseif gear > 10
            gear = 10;
        end
    end
    brakeTemperature = ambientTemperature + GetNextRelativeBrakeTemperature(deltaBrakeTemperature, tau, cH, pedalPressure, dt);
    gravityForce = GetGravityForce(alpha,m,g);
    brakingForce = GetBrakingForce(pedalPressure, brakeTemperature, maxTemperature, m, g);
    engineBrakingForce = GetEngineBrakingForce(cB, gear);
    sprintf('t is %.2f, x is %.2f, v is %.2f, gear is %d, TB is %.1f, DeltaGear is %d, PP is %.4f', ...
    t, x, v, gear, brakeTemperature, deltaGear, pedalPressure)
    if v>vMax || v<vMin
        break
    elseif brakeTemperature > maxTemperature
        break
    end
    [v,x] = GetNextVelocityAndPosition(v,x,gravityForce,brakingForce,engineBrakingForce,m,dt);
    xArray = [xArray, x];
    vArray = [vArray, v];
end
if x>slopeLength
    xArray(end) = slopeLength;
end
end