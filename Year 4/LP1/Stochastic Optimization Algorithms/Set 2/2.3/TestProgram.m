% Program that allows testing the best network on an arbitrary slope. To
% edit the slope, edit the GetSlopeAngleFunction. If the slope isn't
% finished, the message 'Did not finish the slope!' is printed.
numberOfHiddenNeurons = 8;
bestChromosome = [-5.17643597165147,3.66114336553993,5.02628207241388,7.55069256204279,9.28642276231073,8.23323333877910,3.82781006232164,-1.00224210759636,-8.70952362551992,8.99759918520764,2.46810857641965,-11.2166248535386,-1.89236573487369,-3.16983302313725,-3.45817415843178,-8.79855285360815,7.26544204160787,4.65888434605439,3.04419012080463,3.91841839896708,-7.13889361504177,3.92054351311842,-5.86114087357777,-6.26257901133755,7.82814725508256,-6.58367271539341,-9.50150873965134,-0.498195165053046,-10.7100209745913,-4.19651197709411,3.68706028906341,10.8175931517311,9.46363896169102,5.71994127271461,-3.40134195521458,-6.49120422061863,-9.35355789412533,0.241011145839933,5.18160569414796,-5.58162821557415,-4.38293157817115,8.90002985255725,-5.74164356334185,6.77705022458559,0.927923485756788,-6.19414856132959,-11.6757102846579,-2.55746509900755,-9.88428985666312,3.18306917221923];

GetSlopeAngleFunction = @(x) 4 + 3*sin(x/100) + cos(sqrt(2)*x/50);

[alphaArray, pedalPressureArray, gearArray, vArray, brakeTemperatureArray] = ...
    DriveTruckTest(bestChromosome, numberOfHiddenNeurons, GetSlopeAngleFunction);

subplot(3,2,1)
plot(alphaArray)
title('\textbf{Slope angle}','interpreter','latex')
ylabel('$\alpha$ [degrees]','interpreter','latex')
xlabel('Time [s]','interpreter','latex')
ylim([0 10])

subplot(3,2,2)
plot(pedalPressureArray)
title('\textbf{Pedal pressure}','interpreter','latex')
ylabel('$P_P$','interpreter','latex')
xlabel('Time [s]','interpreter','latex')
ylim([-0.05 1.05])

subplot(3,2,3)
plot(gearArray)
title('\textbf{Gear}','interpreter','latex')
ylabel('Gear number','interpreter','latex')
xlabel('Time [s]','interpreter','latex')
ylim([0 11])

subplot(3,2,4)
plot(vArray)
title('\textbf{Speed}','interpreter','latex')
ylabel('v [m/s]','interpreter','latex')
xlabel('Time [s]','interpreter','latex')
ylim([5 25])

subplot(3,2,5)
plot(brakeTemperatureArray)
title('\textbf{Brake temperature}','interpreter','latex');
ylabel('$T_B$ [K]','interpreter','latex')
xlabel('Time [s]','interpreter','latex')
ylim([283, 750])