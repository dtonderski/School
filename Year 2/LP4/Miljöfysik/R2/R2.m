%%
clear,clc;
data = load("data.txt");
e = 1.60e-19;
h = 6.63e-34;
c = 299792000;
%% R1_O1
wavelength = data(:,1);
power = data(:, 2);

solarintensity = calculateintensity(0, inf, wavelength, power)
generatedintensity = 0.21*solarintensity;
neededintensity = 1800;
area = neededintensity/generatedintensity;
%% R1_O2
fillfactor = 0.81;
upperwavelength = h*c/(1.2*e)*10^9;
Nelectronsperareasecond = 0;
upperindex = max(find(wavelength<upperwavelength));
for i = 1:upperindex
   wavelengthintensity = power(i)*(wavelength(i+1)-wavelength(i));
   Nelectronsperareasecond = Nelectronsperareasecond + wavelengthintensity / (h*c/(wavelength(i)*10^-9));
end
ampereperarea = Nelectronsperareasecond*e;
generatedpower = 0.81*ampereperarea*0.98