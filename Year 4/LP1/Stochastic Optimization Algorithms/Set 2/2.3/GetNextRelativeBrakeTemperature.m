function deltaTB = GetNextRelativeBrakeTemperature(deltaTB,tau,CH,PP, dt)
if PP < 0.01
    deltaTB = deltaTB + dt*(-deltaTB/tau);
else
    deltaTB = deltaTB + CH*PP*dt;
end
end

