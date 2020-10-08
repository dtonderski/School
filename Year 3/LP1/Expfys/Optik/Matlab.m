clear;clc;clf;

%% bra-mätning
filename = "bra-mätning.xlsx";
start_meas = 50;
end_meas = 350;
data = readtable(filename);
data = table2array([data(:,2) data(:,4)]);
for i=length(data):-1:1
    if data(i,2)==0
        data(i,:)=[];
    end
end
pressure = data(:,2);
voltage = data(:,1);
[~,locs] = findpeaks(voltage(start_meas:end_meas));
locs=locs+start_meas-1;
plot(pressure,voltage);
hold on
for i=1:length(locs)
    plot(pressure(locs(i)),voltage(locs(i)),'o')
end

N_peaks = length(locs)-1;
delta_p = pressure(end_meas)-pressure(start_meas);
p_0 = pressure(length(pressure));
d = 0.05;
lambda = 633e-9;

format long g
n_0 = N_peaks*lambda*p_0/(delta_p*2*d)+1;
N = [N_peaks];
P_0 = [p_0];
delta_P = [delta_p];
%% bra-mätning-2
filename = "bra-mätning-2.xlsx";
start_meas = 20;
end_meas = 300;
data = readtable(filename);
data = table2array([data(:,2) data(:,4)]);
for i=length(data):-1:1
    if data(i,2)==0
        data(i,:)=[];
    end
end
pressure = data(:,2);
voltage = data(:,1);
[pks,locs] = findpeaks(voltage(start_meas:end_meas));
locs=locs+start_meas-1;
plot(pressure,voltage);
hold on
for i=1:length(locs)
    plot(pressure(locs(i)),voltage(locs(i)),'o')
end

N_peaks = length(locs)-1;
delta_p = pressure(end_meas)-pressure(start_meas);
p_0 = pressure(length(pressure));
d = 0.05;
lambda = 633e-9;

format long g
n_0 = [n_0; N_peaks*lambda*p_0/(delta_p*2*d)+1];
N = [N; N_peaks];
P_0 = [P_0; p_0];
delta_P = [delta_P; delta_p];
%% bra-mätning-3
filename = "bra-mätning-3.xlsx";
start_meas = 35;
end_meas = 365;
data = readtable(filename);
data = table2array([data(:,2) data(:,4)]);
for i=length(data):-1:1
    if data(i,2)==0
        data(i,:)=[];
    end
end
pressure = data(:,2);
voltage = data(:,1);
[pks,locs] = findpeaks(voltage(start_meas:end_meas));
locs=locs+start_meas-1;
plot(pressure,voltage);
hold on
for i=1:length(locs)
    plot(pressure(locs(i)),voltage(locs(i)),'o')
end

N_peaks = length(locs)-1;
delta_p = pressure(end_meas)-pressure(start_meas);
p_0 = pressure(length(pressure));
d = 0.05;
lambda = 633e-9;

format long g
n_0 = [n_0; N_peaks*lambda*p_0/(delta_p*2*d)+1];
N = [N; N_peaks];
P_0 = [P_0; p_0];
delta_P = [delta_P; delta_p];
%% bra-mätning-4
filename = "bra-mätning-4.xlsx";
start_meas = 55;
end_meas = 365;
data = readtable(filename);
data = table2array([data(:,2) data(:,4)]);
for i=length(data):-1:1
    if data(i,2)==0
        data(i,:)=[];
    end
end
pressure = data(:,2);
voltage = data(:,1);
[pks,locs] = findpeaks(voltage(start_meas:end_meas));
locs=locs+start_meas-1;
plot(pressure,voltage);
hold on
for i=1:length(locs)
    plot(pressure(locs(i)),voltage(locs(i)),'o')
end

N_peaks = length(locs)-1;
delta_p = pressure(end_meas)-pressure(start_meas);
p_0 = pressure(length(pressure));
d = 0.05;
lambda = 633e-9;

format long g
n_0 = [n_0; N_peaks*lambda*p_0/(delta_p*2*d)+1];
N = [N; N_peaks];
P_0 = [P_0; p_0];
delta_P = [delta_P; delta_p];
%% Bra-mätning-5
filename = "Bra-mätning-5.xlsx";
start_meas = 25;
end_meas = 312;
data = readtable(filename);
data = table2array([data(:,2) data(:,4)]);
for i=length(data):-1:1
    if data(i,2)==0
        data(i,:)=[];
    end
end
pressure = data(:,2);
voltage = data(:,1);

[pks,locs] = findpeaks(voltage(start_meas:end_meas));
locs=locs+start_meas-1;
plot(pressure,voltage);
hold on
for i=1:length(locs)
    plot(pressure(locs(i)),voltage(locs(i)),'o')
end

N_peaks = length(locs)-1;
delta_p = pressure(end_meas)-pressure(start_meas);
p_0 = pressure(length(pressure));
d = 0.05;
lambda = 633e-9;

format long g
n_0 = [n_0; N_peaks*lambda*p_0/(delta_p*2*d)+1];
N = [N; N_peaks];
P_0 = [P_0; p_0];
delta_P = [delta_P; delta_p];
%% Bra-mätning-6
filename = "Bra-mätning-6.xlsx";
start_meas = 67;
end_meas = 301;
data = readtable(filename);
data = table2array([data(:,2) data(:,4)]);
for i=length(data):-1:1
    if data(i,2)==0
        data(i,:)=[];
    end
end
pressure = data(:,2);
voltage = data(:,1);

[pks,locs] = findpeaks(voltage(start_meas:end_meas));
locs=locs+start_meas-1;
plot(pressure,voltage);
hold on
for i=1:length(locs)
    plot(pressure(locs(i)),voltage(locs(i)),'o')
end

N_peaks = length(locs)-1;
delta_p = pressure(end_meas)-pressure(start_meas);
p_0 = pressure(length(pressure));
d = 0.05;
lambda = 633e-9;

format long g
n_0 = [n_0; N_peaks*lambda*p_0/(delta_p*2*d)+1];
N = [N; N_peaks];
P_0 = [P_0; p_0];
delta_P = [delta_P; delta_p];
%% Bra-mätning-7
filename = "Bra-mätning-7.xlsx";
start_meas = 20;
end_meas = 308;
data = readtable(filename);
data = table2array([data(:,2) data(:,4)]);
for i=length(data):-1:1
    if data(i,2)==0
        data(i,:)=[];
    end
end
pressure = data(:,2);
voltage = data(:,1);

[pks,locs] = findpeaks(voltage(start_meas:end_meas));
locs=locs+start_meas-1;
plot(pressure,voltage);
hold on
for i=1:length(locs)
    plot(pressure(locs(i)),voltage(locs(i)),'o')
end

N_peaks = length(locs)-1;
delta_p = pressure(end_meas)-pressure(start_meas);
p_0 = pressure(length(pressure));
d = 0.05;
lambda = 633e-9;

format long g
n_0 = [n_0; N_peaks*lambda*p_0/(delta_p*2*d)+1];
N = [N; N_peaks];
P_0 = [P_0; p_0];
delta_P = [delta_P; delta_p];
%% Bra-mätning-8
filename = "Bra-mätning-8.xlsx";
start_meas = 26;
end_meas = 350;
data = readtable(filename);
data = table2array([data(:,2) data(:,4)]);
for i=length(data):-1:1
    if data(i,2)==0
        data(i,:)=[];
    end
end
pressure = data(:,2);
voltage = data(:,1);

[pks,locs] = findpeaks(voltage(start_meas:end_meas));
locs=locs+start_meas-1;
plot(pressure,voltage);
hold on
for i=1:length(locs)
    plot(pressure(locs(i)),voltage(locs(i)),'o')
end

N_peaks = length(locs)-1;
delta_p = pressure(end_meas)-pressure(start_meas);
p_0 = pressure(length(pressure));
d = 0.05;
lambda = 633e-9;

format long g
n_0 = [n_0; N_peaks*lambda*p_0/(delta_p*2*d)+1];
N = [N; N_peaks];
P_0 = [P_0; p_0];
delta_P = [delta_P; delta_p];
%% Bra-mätning-9
filename = "Bra-mätning-9.xlsx";
start_meas = 29;
end_meas = 346;
data = readtable(filename);
data = table2array([data(:,2) data(:,4)]);
for i=length(data):-1:1
    if data(i,2)==0
        data(i,:)=[];
    end
end
pressure = data(:,2);
voltage = data(:,1);

[pks,locs] = findpeaks(voltage(start_meas:end_meas));
locs=locs+start_meas-1;
plot(pressure,voltage);
hold on
for i=1:length(locs)
    plot(pressure(locs(i)),voltage(locs(i)),'o')
end

N_peaks = length(locs)-1;
delta_p = pressure(end_meas)-pressure(start_meas);
p_0 = pressure(length(pressure));
d = 0.05;
lambda = 633e-9;

format long g
n_0 = [n_0; N_peaks*lambda*p_0/(delta_p*2*d)+1];
N = [N; N_peaks];
P_0 = [P_0; p_0];
delta_P = [delta_P; delta_p];
%% Bra-mätning-10.xlsx
filename = "Bra-mätning-10.xlsx";
start_meas = 43;
end_meas = 341;
data = readtable(filename);
data = table2array([data(:,2) data(:,4)]);
for i=length(data):-1:1
    if data(i,2)==0
        data(i,:)=[];
    end
end
pressure = data(:,2);
voltage = data(:,1);
[pks,locs] = findpeaks(voltage(start_meas:end_meas));
locs=locs+start_meas-1;
plot(pressure,voltage);
hold on
for i=1:length(locs)
    plot(pressure(locs(i)),voltage(locs(i)),'o')
end

N_peaks = length(locs)-1;
delta_p = pressure(end_meas)-pressure(start_meas);
p_0 = pressure(length(pressure));
d = 0.05;
lambda = 633e-9;

format long g
n_0 = [n_0; N_peaks*lambda*p_0/(delta_p*2*d)+1];
N = [N; N_peaks];
P_0 = [P_0; p_0];
delta_P = [delta_P; delta_p];
%%
n_0_average = mean(n_0)
N_average = mean(N)
P_0_average = mean(P_0)
delta_P_average = mean(delta_P)