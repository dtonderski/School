function engineBreakingForce = GetEngineBrakingForce(cB, gear)
constant = [7.0, 5.0, 4.0, 3.0, 2.5, 2.0, 1.6, 1.4, 1.2, 1.0];
engineBreakingForce = constant(gear)*cB;
end

