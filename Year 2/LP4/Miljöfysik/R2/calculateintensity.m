function totalintensity = calculateintensity(lower, upper, wavelength, power)
%CALCULATEINTENSITY Summary of this function goes here
%   wavelength in nm, power in W/m^2/nm
lowerindex = min(find(wavelength>lower));
upperindex = max(find(wavelength<upper));


totalintensity = 0;

for i = lowerindex:upperindex
    if i == upperindex
        totalintensity = totalintensity + power(i)*(wavelength(i)-wavelength(i-1));
    else
        totalintensity = totalintensity + power(i)*(wavelength(i+1)-wavelength(i));
    end
end

