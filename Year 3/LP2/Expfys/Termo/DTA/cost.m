function value = cost(phasetrans, peo, peominusal2o3)
%COST Summary of this function goes here
%   Detailed explanation goes here
peo1 = peo(1:phasetrans);
peominusal2o31 = peominusal2o3(1:phasetrans);

peo2 = peo(phasetrans:end);
peominusal2o32 = peominusal2o3(phasetrans:end);

[p, S] = polyfit(peo1, peominusal2o31, 1);
cost = getfield(S,"normr");

[p, S] = polyfit(peo2, peominusal2o32, 1);
cost = sqrt(cost^2 + getfield(S, "normr")^2);

value = cost;
end

