function brakingForce = GetBrakingForce(pedalPressure, brakeTemperature, maxTemperature, m, g)
if brakeTemperature < maxTemperature - 100
    brakingForce = m*g/20*pedalPressure;
else
    brakingForce = m*g/20*pedalPressure*exp(-(brakeTemperature - (maxTemperature - 100))/100);
end
end

