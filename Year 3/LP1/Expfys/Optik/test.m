filenames = ["Bra-mätning.xlsx","Bra-mätning-2.xlsx","Bra-mätning-3.xlsx", "Bra-mätning-4.xlsx", "Bra-mätning-5.xlsx"...
    "Bra-mätning-6.xlsx", "Bra-mätning-7.xlsx","Bra-mätning-8.xlsx","Bra-mätning-9.xlsx","Bra-mätning-10.xlsx"];
start_meass = [50, 20, 35, 55, 25, 67, 20, 26, 29, 43];
end_meass = [350, 300, 365, 365, 312, 301, 308, 350, 346, 341];

n_0=[];
N=[];
P_0=[];
delta_P=[];

for m = 1:length(filenames)
    clf
    filename = filenames(m);
    start_meas = start_meass(m);
    end_meas = end_meass(m);
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
    for i=1:length(locs)
        plot(pressure(locs(i)),voltage(locs(i)),'o')
    end

    N_peaks = length(locs)-1;
    delta_p = pressure(end_meas)-pressure(start_meas);
    p_0 = pressure(length(pressure));
    d = 0.05;
    lambda = 633e-9;
    n_0 = [n_0; N_peaks*lambda*p_0/(delta_p*2*d)+1];
    N = [N; N_peaks];
    P_0 = [P_0; p_0];
    delta_P = [delta_P; delta_p];
end
n_0_average = mean(n_0)
N_average = mean(N)
P_0_average = mean(P_0)
delta_P_average = mean(delta_P)
