Intensities = [7852
5398
3808
2896
1900
1804
1444
1348
1126
1120
958
871
733
598
559
490
379
340
313
250
256
235
166
126.4
107.2
72.4];

Times = [35
55
75
95
115
135
155
175
195
215
235
260
290
320
350
380
410
440
470
500
530
560
590
635
695
755
];

logintensities = log(Intensities);
plot(Times, logintensities)
logintensities2 = logintensities(10:26);
Times2 = Times(10:26);
p = polyfit(Times2, logintensities2, 1);
lambda2 = -p(1);
N02 = exp(p(2))/lambda2;

intensities2 = N02*lambda2*exp(-lambda2*Times);
clf

plot(Times, intensities2)
hold on
plot(Times, Intensities)

intensities1 = Intensities - intensities2;
logintensities1 = log(abs(intensities1));
p = polyfit(Times(1:9), logintensities1(1:9), 1);
lambda1 = -p(1);
N01 = exp(p(2))/lambda1;
intensities1 = N01*lambda1*exp(-lambda1*Times);
plot(Times,intensities1)0

plot(Times,intensities1+intensities2)

halveringstid1 = log(2)/(lambda1)
halveringstid2 = log(2)/(lambda2)

