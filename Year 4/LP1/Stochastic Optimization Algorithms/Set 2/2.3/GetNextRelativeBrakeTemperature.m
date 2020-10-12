function deltaBrakeTemperature = GetNextRelativeBrakeTemperature(deltaBrakeTemperature,tau,cH,pedalPressure, dt)
if pedalPressure < 0.01
    deltaBrakeTemperature = deltaBrakeTemperature + dt*(-deltaBrakeTemperature/tau);
else
    deltaBrakeTemperature = deltaBrakeTemperature + cH*pedalPressure*dt;
end
end

