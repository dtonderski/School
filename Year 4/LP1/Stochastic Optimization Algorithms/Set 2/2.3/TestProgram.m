numberOfHiddenNeurons = 8;
bestChromosome = [-3.48333487335850,6.90603370095627,-7.10228675299292,-10.1789156041075,9.17058315990986,-4.92565472263846,-1.31383116401328,-7.89955122076400,-1.28068849921775,-9.93851062357950,7.99499309659279,6.27278815000536,5.72353994748876,4.21267564507066,-8.08242852438676,-2.02222415935926,6.01690399499396,1.43942255040296,2.48230391416942,-3.86668850219659,4.81160087497184,9.64224949318594,8.77977497180796,-4.59121929624562,3.88178685381496,0.888176766647435,-4.92617421022100,4.52446759640344,-5.26015045038687,-5.11505539217179,4.88114864490571,-10.3978711072193,1.04887772022257,-6.06810987190654,9.07259856743909,-9.52524467508924,-8.32315971809027,7.08779806791211,9.91785700884898,-9.40535389637104,-7.45927786017197,-3.04048603705785,-9.23879734106302,8.56360265041901,10.1479880407249,-4.17050724713018,-7.47465049704863,7.03494462128025,6.31493880842238,-3.15747019362132];

iSlope = 6;
iDataSet = 1;

[alphaArray, pedalPressureArray, gearArray, vArray, brakeTemperatureArray] = ...
    DriveTruckTest(bestChromosome, numberOfHiddenNeurons, iSlope, iDataSet);

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
ylim([0 1])

subplot(3,2,3)
plot(gearArray)
title('\textbf{Gear}','interpreter','latex')
ylabel('Gear number','interpreter','latex')
xlabel('Time [s]','interpreter','latex')
ylim([0 11])

subplot(3,2,4)
plot(vArray)
title('\textbf{Velocity}','interpreter','latex')
ylabel('v [m/s]','interpreter','latex')
xlabel('Time [s]','interpreter','latex')
ylim([5 25])

subplot(3,2,5)
plot(brakeTemperatureArray)
title('\textbf{Brake temperature}','interpreter','latex');
ylabel('$T_B$ [K]','interpreter','latex')
xlabel('Time [s]','interpreter','latex')
ylim([283, 750])