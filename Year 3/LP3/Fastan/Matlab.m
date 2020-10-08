%% Beskrivning, uträkning av nödvändiga värden
% En lösning i MATLAB verkade enklast då många beräkningar krävs. Först
% räknas sinus av de uppmätta vinklarna upp. Sedan räknas de 8 första 
% värdena på sqrt(h^2 + k^2 + l^2) ut enligt tabell. För kristallstrukturen
% vi söker blir sqrt(h^2+k^2+l^2)/sin(theta) =  2*a/lambda, alltså ett
% konstant värde. För varje kristallstruktur plottas dessa värden. För både 
% SC och BCC blev det inte konstant, men för FCC blev det (i princip) 
% konstant. Därmed är FCC den sökta kristallstrukturen.
% a räknas ut separat sedan ut för varje (vinkel, hkl)-kombination. Det 
% slutgiltiga värdet på a är medelvärdet av alla beräknade a-n, och detta
% blir ca. 4 Å.

%Räknar ut nödvändiga värden
lambda = 1.54;
anglesdeg = [19.48,22.64,33.0,39.68,41.83,50.35,57.05,59.42];
sinusangles = sind(anglesdeg);
hklSC = sqrt([1,2,3,4,5,6,8,9]);
hklBCC = sqrt([2,4,6,8,10,12,14,16]);
hklFCC = sqrt([3,4,8,11,12,16,19,20]);
%% Plottar ration för SC
figure(1)
SCratio = hklSC./sinusangles;
plot(1:8,SCratio,'o')
title('SC')
ylim([2 6])

%% Plottar ration för BCC
figure(2)
BCCratio = hklBCC./sinusangles;
plot(1:8, BCCratio,'o')
title('BCC')
ylim([2 6])

%% Plottar ration för FCC
figure(3)
FCCratio = hklFCC./sinusangles;
plot(1:8,FCCratio,'o')
title('FCC')
ylim([2 6])
%% Visar a
%Ration för FCC är nästan konstant, så detta är den sökta strukturen
a = mean(lambda/2 * FCCratio);
disp(a) %3.9997 