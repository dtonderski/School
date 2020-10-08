
%%
minpeak = 0.00006;
%%
clf
subplot(3,1,1)
dataHg = xlsread('Hg/200-1100, 0.03/Meas_48.xlsx');
voltageHg = dataHg(2:end, 1) - mean(dataHg(2:end,1));
wavelengthHg = dataHg(2:end, 2);
plot(wavelengthHg, voltageHg);
[pksVoltageHg, pksWavelengthHg] = findpeaks(voltageHg,wavelengthHg, 'MinPeakHeight', minpeak, 'MinPeakDistance', 0.3);
hold on
plot(pksWavelengthHg, pksVoltageHg, 'or')
%%
subplot(3,1,2)
dataFe = xlsread('Fe\200-1100, 0.03/Meas_52.xlsx');
voltageFe = dataFe(2:end, 1) - mean(dataFe(2:end,1));
wavelengthFe = dataFe(2:end, 2);
plot(wavelengthFe, voltageFe);
[pksVoltageFe, pksWavelengthFe] = findpeaks(voltageFe,wavelengthFe, 'MinPeakHeight', minpeak, 'MinPeakDistance', 0.3);
hold on
plot(pksWavelengthFe, pksVoltageFe, 'or')

%%
subplot(3,1,3)
dataFe1 = xlsread('Fe\200-1100, 0.03/Meas_53.xlsx');
voltageFe1 = dataFe1(2:end, 1) - mean(dataFe1(2:end,1));
wavelengthFe1 = dataFe1(2:end, 2);
plot(wavelengthFe1, voltageFe1);
[pksVoltageFe1, pksWavelengthFe1] = findpeaks(voltageFe1,wavelengthFe1, 'MinPeakHeight', minpeak, 'MinPeakDistance', 0.3);
hold on
plot(pksWavelengthFe1, pksVoltageFe1, 'or')
hold off
%%
FeData = [pksWavelengthFe, pksVoltageFe./max([pksVoltageFe])];
Fe1Data = [pksWavelengthFe1, pksVoltageFe1./max(pksVoltageFe)];
finalData = sortrows([FeData;Fe1Data])
%%
clf
subplot(2,1,1)
plot(wavelengthFe, voltageFe/max(voltageFe), 'black')
hold on
plot(pksWavelengthFe, pksVoltageFe/max(voltageFe), 'or')
ylim([-0.1, 1.1])
set(gca,'FontSize',22);
ylabel('Relativ intensitet $I/I_0$', 'Interpreter', 'latex')
xlabel('V\aa gl\"angd [nm]', 'Interpreter', 'latex')
title('\textbf{M\"atning 1}', 'Interpreter', 'latex', 'FontSize', 25)

subplot(2,1,2)
hold on
plot(wavelengthFe1, voltageFe1/max(voltageFe1), 'black');
plot(pksWavelengthFe1, pksVoltageFe1/max(voltageFe1), 'or')
ylim([-0.1, 1.1])
set(gca,'FontSize',22);
ylabel('Relativ intensitet $I/I_0$', 'Interpreter', 'latex')
xlabel('V\aa gl\"angd [nm]', 'Interpreter', 'latex')
subplot(2,1,2)
title('\textbf{M\"atning 2}', 'Interpreter', 'latex', 'FontSize', 25)

%%
clf
plot([HgTab ;NeTab], [HgUppmatt ;NeUppmatt], '.black','MarkerSize', 35)
set(gca,'FontSize',35);
xlabel('Tabellv\"arde p\aa \ relativ intensitet $I/I_0$', 'Interpreter', 'latex')
ylabel('Uppm\"att relativ intensitet $I/I_0$', 'Interpreter', 'latex')




