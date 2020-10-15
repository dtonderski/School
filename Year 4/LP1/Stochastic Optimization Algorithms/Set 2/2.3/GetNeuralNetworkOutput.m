function [pedalPressure, deltaGear] = GetNeuralNetworkOutput(input,w1,w2)
input = [1;input];
s1 = [1; GetSigmoid(w1*input)];
s2 = w2*s1;
pedalPressure = GetSigmoid(s2(1));
gearOutput = GetSigmoid(s2(2));
if gearOutput < 0.3
    deltaGear = -1;
elseif gearOutput > 0.7
    deltaGear = 1;
else
    deltaGear = 0;
end
end