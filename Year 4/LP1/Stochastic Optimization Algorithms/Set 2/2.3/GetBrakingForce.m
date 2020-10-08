function breakingForce = GetBrakingForce(PP, TB, TMax, M, g)
if TB < TMax - 100
    breakingForce = M*g/20*PP;
else
    breakingForce = M*g/20*PP*exp(-(TB - (TMax - 100))/100);
end
end

