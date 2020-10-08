%% Beskrivning, utr�kning av n�dv�ndiga v�rden
% En l�sning i MATLAB verkade enklast d� m�nga ber�kningar kr�vs. F�rst
% r�knas sinus av de uppm�tta vinklarna upp. Sedan r�knas de 8 f�rsta 
% v�rdena p� sqrt(h^2 + k^2 + l^2) ut enligt tabell. F�r kristallstrukturen
% vi s�ker blir sqrt(h^2+k^2+l^2)/sin(theta) =  2*a/lambda, allts� ett
% konstant v�rde. F�r varje kristallstruktur plottas dessa v�rden. F�r b�de 
% SC och BCC blev det inte konstant, men f�r FCC blev det (i princip) 
% konstant. D�rmed �r FCC den s�kta kristallstrukturen.
% a r�knas ut separat sedan ut f�r varje (vinkel, hkl)-kombination. Det 
% slutgiltiga v�rdet p� a �r medelv�rdet av alla ber�knade a-n, och detta
% blir ca. 4 �.

%R�knar ut n�dv�ndiga v�rden
lambda = 1.54;
anglesdeg = [19.48,22.64,33.0,39.68,41.83,50.35,57.05,59.42];
sinusangles = sind(anglesdeg);
hklSC = sqrt([1,2,3,4,5,6,8,9]);
hklBCC = sqrt([2,4,6,8,10,12,14,16]);
hklFCC = sqrt([3,4,8,11,12,16,19,20]);
%% Plottar ration f�r SC
figure(1)
SCratio = hklSC./sinusangles;
plot(1:8,SCratio,'o')
title('SC')
ylim([2 6])

%% Plottar ration f�r BCC
figure(2)
BCCratio = hklBCC./sinusangles;
plot(1:8, BCCratio,'o')
title('BCC')
ylim([2 6])

%% Plottar ration f�r FCC
figure(3)
FCCratio = hklFCC./sinusangles;
plot(1:8,FCCratio,'o')
title('FCC')
ylim([2 6])
%% Visar a
%Ration f�r FCC �r n�stan konstant, s� detta �r den s�kta strukturen
a = mean(lambda/2 * FCCratio);
disp(a) %3.9997 