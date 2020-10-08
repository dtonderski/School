data = load("data/na22_coinc_90.txt");
datawithoutzeros = data;

detector1zeros = find(datawithoutzeros(:,1) == 0);
datawithoutzeros(detector1zeros, :) = [];

detector2zeros = find(datawithoutzeros(:,2) == 0);
datawithoutzeros(detector2zeros, :) = [];

figure(1)
detector1 = datawithoutzeros(:,1);
histogram(detector1, max(detector1));

figure(2)
detector2 = datawithoutzeros(:,2);
histogram(detector2,max(detector2));

%Detector2 är lite större, därför högre counts

%% Kalibrering
peaklarge1 = 3748.5;
peaklarge2 = 3746.5;
peaklargeval = 1332.501;

scaling1 = peaklargeval/peaklarge1;
scaling2 = peaklargeval/peaklarge2;

detector1scaled = detector1.*scaling1;
detector2scaled = detector2.*scaling2;

% Testa
figure(1)
histogram(detector1scaled, round(max(detector1scaled)));

figure(2)
histogram(detector2scaled, round(max(detector2scaled)));

%% Coincidenskravet
validindices = find(datawithoutzeros(:,3)==0);
detector1scaledcoincidence = detector1scaled(validindices);
detector2scaledcoincidence = detector2scaled(validindices);

% Plotta med coincidence
% Testa
figure(1)
histogram(detector1scaledcoincidence, round(max(detector1scaled)));

figure(2)
histogram(detector2scaledcoincidence, round(max(detector2scaled)));

%%
plot(detector1scaledcoincidence, detector2scaledcoincidence, '.')