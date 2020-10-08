function [PP, DeltaGear] = GetNeuralNetworkOutput(input,w1,w2)
input = [1;input];
s1 = [1; GetSigmoid(w1*input)];
s2 = w2*s1;
PP = GetSigmoid(s2(1));
DeltaGear = sign(s2(2));
end