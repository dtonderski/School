function [PP, DeltaGear] = GetNeuralNetworkOutput(input,w1,w2)
input = [1;input];
s1 = [1; GetSigmoid(w1*input)];
s2 = w2*s1;
PP = GetSigmoid(s2(1));
gearOutput = GetSigmoid(s2(2));
if gearOutput < 0.3
    DeltaGear = -1;
elseif gearOutput > 0.7
    DeltaGear = 1;
else
    DeltaGear = 0;
end
end