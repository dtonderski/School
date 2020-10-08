function [xArray,vArray] = DriveTruck(chromosome, NH, iSlope, iDataSet)
% Constants
TMax = 750;     % K
M = 20000;      % kg
tau = 30;       % s
CH = 40;        % K/s
TAmb = 283;     % K
CB = 3000;      % N
vMax = 25;      % m/s
vMin = 1;       % m/s
alphaMax = 10;  % deg
g = 9.81;       % m/s^2
dt = 0.25;       % s
L = 1000;       % m

% Initialization
x = 0;          % m
v = 20;         % m/s
gear = 7;       
TB = 500;       % K
t = 0;
xArray = x;
vArray = v;
tGearLastChanged = -2;

% Main loop
while x < L
    t = t+dt;
    alpha = GetSlopeAngle(x, iSlope, iDataSet);
    deltaTB = TB - TAmb;
    [w1, w2] = DecodeChromosome(chromosome,NH);
    input = [v/vMax; alpha/alphaMax; TB/TMax];
    [PP, DeltaGear] = GetNeuralNetworkOutput(input,w1,w2);
    if t-tGearLastChanged>=2
        gear = gear + DeltaGear;
        if gear < 1
            gear = 1;
        elseif gear > 10
            gear = 10;
        end
    end
    TB = TAmb + GetNextRelativeBrakeTemperature(deltaTB, tau, CH, PP, dt);
    FG = GetGravityForce(alpha,M,g);
    FB = GetBrakingForce(PP, TB, TMax, M, g);
    FEb = GetEngineBrakingForce(CB, gear);
    if v>vMax || v<vMin
        break
    elseif TB > TMax
        break
    end
    [v,x] = GetNextVelocityAndPosition(v,x,FG,FB,FEb,M,dt);
    xArray = [xArray, x];
    vArray = [vArray, v];
end
if x>L
    xArray(end) = L;
end
end