%% Uppgift 1a, b
clc
n = 2;                          % Parameter till binomialdistributionen
N_gen_arr = [20, 40, 60, 100];  % Antalet generationer
N_prov_bin_a = 10000;           % Antal testade infektionsträd
p_arr_bin = linspace(0.4, 0.6); % Värden av p
N_doda_arr_bin = zeros([length(p_arr) length(N_gen_arr)]);


for N_gen_index = 1:length(N_gen_arr)
    N_gen = N_gen_arr(N_gen_index);
    for p_index = 1:length(p_arr_bin)
        p = p_arr_bin(p_index);
        N_doda = 0;
        disp(strcat('Uppgift 1a,b, N_gen = ', int2str(N_gen), ', p = ',...
            num2str(p)))
        for prov = 1:N_prov_bin_a
            N_smittade = 1;               % initiala antalet smittade
            for gen = 1:N_gen
                N_smittade_gen = bnldev(N_smittade*n, p); % antalet smittade i generationen

                if N_smittade_gen > 1000
                    break
                end

                if N_smittade_gen == 0    % 0 nya smittningar betyder dött träd
                    N_doda = N_doda + 1;
                    break
                end
                N_smittade = N_smittade_gen;
            end
        end
        N_doda_arr_bin(N_gen_index,p_index) = N_doda;
    end
end
%% Uppgift 1a, 1b - plottar
figure(1)
subplot(2,2,1)
plot(p_arr_bin, 1-N_doda_arr_bin(1,:)/N_prov_bin_a)
title("Sannolikheten att Z_{20} = 0, binomial")
xlabel("p")
ylabel("Sannolikhet")
set(gca,'FontSize',18)

subplot(2,2,2)
plot(p_arr_bin, 1-N_doda_arr_bin(2,:)/N_prov_bin_a)
title("Sannolikheten att Z_{40} = 0, binomial")
xlabel("p")
ylabel("Sannolikhet")
set(gca,'FontSize',18)

subplot(2,2,3)
plot(p_arr_bin, 1-N_doda_arr_bin(3,:)/N_prov_bin_a)
title("Sannolikheten att Z_{60} = 0, binomial")
xlabel("p")
ylabel("Sannolikhet")
set(gca,'FontSize',18)

subplot(2,2,4)
plot(p_arr_bin, 1-N_doda_arr_bin(4,:)/N_prov_bin_a)
title("Sannolikheten att Z_{100} = 0, binomial")
xlabel("p")
ylabel("Sannolikhet")
set(gca,'FontSize',18)

%% Uppgift 1c
close all
n = 2;
p_arr = [0.5, 0.55, 0.6];           % Valda värden av p
N_gen = 100;                        % Antalet generationer
N_prov_bin_2 = 10000;               % Antalet prov
N_smittade_gen_100_bin_arr = zeros([length(p_arr) N_prov_bin_2]);

tic
for i = 1:length(p_arr)
    p = p_arr(i);
    for prov = 1:N_prov_bin_2
        disp(strcat('Uppgift 1c, p = ', num2str(p), ', prov = ',...
            num2str(prov)))
        N_smittade = 1;               % Initiala antalet smittade
        for gen = 1:N_gen
            N_smittade_gen = bnldev(N_smittade*n, p); % Antalet smittade i generationen
            if N_smittade_gen == 0 || gen == 100
                N_smittade_gen_100_bin_arr(i, prov) = N_smittade_gen;
                break
            end

            N_smittade = N_smittade_gen;
        end
    end
end
toc

%% Uppgift 1c - plottar
figure(2)
subplot(3,1,1)
histogram(N_smittade_gen_100_bin_arr(1,:).^(1/100), 200)
title("Histogram, p = 0.5")
xlabel("{Z_{100}}^{1/100}")
ylabel("Antal träd")
set(gca,'FontSize',18)

subplot(3,1,2)
histogram(N_smittade_gen_100_bin_arr(2,:).^(1/100), 200)
title("Histogram, p = 0.55")
xlabel("{Z_{100}}^{1/100}")
ylabel("Antal träd")
set(gca,'FontSize',18)

subplot(3,1,3)
histogram(N_smittade_gen_100_bin_arr(3,:).^(1/100), 200)
title("Histogram, p = 0.6")
xlabel("{Z_{100}}^{1/100}")
ylabel("Antal träd")
set(gca,'FontSize',18)
%% Uppgift 2a, b
clc
lambda_arr_a = linspace(0.8, 2, 50);% Valda lambda
N_prov_poi = 10000;                 % Antal testade infektionsträd
N_gen_arr = [20, 40, 60, 100];      % Antalet generationer
N_doda_arr_poi = zeros([length(lambda_arr) length(N_gen_arr)]);

tic
N_doda_arr = [];                    % Antal infektionsträd som dog ut
for N_gen_index = 1:length(N_gen_arr)
    N_gen = N_gen_arr(N_gen_index);
    for lambda_index = 1:length(lambda_arr_a)
        lambda = lambda_arr_a(lambda_index);
        N_doda = 0;
        disp(strcat('Uppgift 1a,b, N_gen = ', int2str(N_gen), ...
            ', lambda = ', num2str(lambda)))
        for prov = 1:N_prov_poi
            N_smittade = 1;               % Initiala antalet smittade
            for gen = 1:N_gen
                N_smittade_gen = poissrnd(N_smittade*lambda); % Antalet smittade i generationen


                if N_smittade_gen > 1000
                    break
                end

                if N_smittade_gen == 0    % 0 nya smittningar betyder dött träd
                    N_doda = N_doda + 1;
                    break
                end
                N_smittade = N_smittade_gen;
            end
        end
        N_doda_arr_poi(N_gen_index, lambda_index) = N_doda;
    end
end

toc
%% Uppgift 2a, 2b - plottar
figure(3)
subplot(2,2,1)
plot(lambda_arr_a, 1-N_doda_arr_poi(1,:)/N_prov_poi)
title("Sannolikheten att Z_{20} = 0, poisson")
xlabel("\lambda")
ylabel("Sannolikhet")
set(gca,'FontSize',18)

subplot(2,2,2)
plot(lambda_arr_a, 1-N_doda_arr_poi(2,:)/N_prov_poi)
title("Sannolikheten att Z_{40} = 0, poisson")
xlabel("\lambda")
ylabel("Sannolikhet")
set(gca,'FontSize',18)

subplot(2,2,3)
plot(lambda_arr_a, 1-N_doda_arr_poi(3,:)/N_prov_poi)
title("Sannolikheten att Z_{60} = 0, poisson")
xlabel("\lambda")
ylabel("Sannolikhet")
set(gca,'FontSize',18)

subplot(2,2,4)
plot(lambda_arr_a, 1-N_doda_arr_poi(4,:)/N_prov_poi)
title("Sannolikheten att Z_{100} = 0, poisson")
xlabel("\lambda")
ylabel("Sannolikhet")
set(gca,'FontSize',18)
%% Uppgift 2c
lambda_arr = [1, 1.5, 2];  % Valda värden av lambda
N_gen = 100;               % Antal generationer 
N_prov = 10000;            % Antal provade träd 

N_smittade_gen_100_poi_arr = zeros([length(p_arr) N_prov]);

tic
for i = 1:length(lambda_arr)
    lambda = lambda_arr(i);
    for prov = 1:N_prov
        disp(strcat('Uppgift 1c, lambda = ', num2str(lambda), ', prov = ',...
            num2str(prov)))
        N_smittade = 1;               % Initiala antalet smittade
        for gen = 1:N_gen
            N_smittade_gen = poissrnd(lambda*N_smittade); % Antalet smittade i generationen
            if N_smittade_gen == 0 || gen == 100          % Trädet är "klart"  
                N_smittade_gen_100_poi_arr(i, prov) = N_smittade_gen;
                break
            end

            N_smittade = N_smittade_gen;
        end
    end
end
toc

%% Uppgift 2c - plottar
figure(4)
subplot(3,1,1)
histogram(N_smittade_gen_100_poi_arr(1,:).^(1/100), 200)
title("Histogram, \lambda = 1")
xlabel("{Z_{100}}^{1/100}")
ylabel("Antal träd")
set(gca,'FontSize',18)

subplot(3,1,2)
histogram(N_smittade_gen_100_poi_arr(2,:).^(1/100), 200)
title("Histogram, \lambda = 1.5")
xlabel("{Z_{100}}^{1/100}")
ylabel("Antal träd")
set(gca,'FontSize',18)


subplot(3,1,3)
histogram(N_smittade_gen_100_poi_arr(3,:).^(1/100), 200)
title("Histogram, \lambda = 2")
xlabel("{Z_{100}}^{1/100}")
ylabel("Antal träd")
set(gca,'FontSize',18)

%% Uppgift 3b
N_gen = 10;
N_prov = 100;

lambda_1 = 2.5;
N_smittade_1 = [];
for prov = 1:N_prov
    N_smittade = 1;               % Initiala antalet smittade
    for gen = 1:N_gen
        N_smittade_gen = poissrnd(lambda_1*N_smittade); % Antalet smittade i generationen
        if N_smittade_gen == 0 || gen == 100
            N_smittade_gen_100_poi_arr(i, prov) = N_smittade_gen;
            break
        end

        N_smittade = N_smittade_gen;
    end
    N_smittade_1 = [N_smittade_1, N_smittade];
end
disp(mean(N_smittade_1))

lambda_2 = 5;
N_smittade_2 = [];
for prov = 1:N_prov
    N_smittade = 1;               % Initiala antalet smittade
    for gen = 1:N_gen
        N_smittade_gen = poissrnd(lambda_2*N_smittade); % Antalet smittade i generationen
        if N_smittade_gen == 0 || gen == 100
            N_smittade_gen_100_poi_arr(i, prov) = N_smittade_gen;
            break
        end

        N_smittade = N_smittade_gen;
    end
    N_smittade_2 = [N_smittade_2, N_smittade];
end
disp(mean(N_smittade_2))

