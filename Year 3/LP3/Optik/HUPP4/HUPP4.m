clear, clc, close all

N = 100; % Antalet observationspunkter
D_star = 45 * 1.3927e9; % 45 soldiametrar
L = 70 * 9.461e15; % 70 ljusår i m
lambda_noll = 650e-9; % 650 nm i m
u_max = 20; % maximala värdet på u i m
N_reps = 1000; % antal gånger koherensen och intensiteten beräknas
[x,y,M] = xy_source(N, D_star, D_star/30);

uvekt = 0 : u_max/(N-1): u_max; % N-1 pga vi vill ha 0 och 20
u =  repmat(uvekt, M, 1);
r = - x./L.*u;

instantana_produkter = []; % För att beräkna gamma_AB
I_obs_insts = []; % För att beräkna I
instantana_produkter_I = []; % För att beräkna gamma_I


for i = [1:N_reps]
    fas_vekt = rand(M,1)*2*pi;
    fas = repmat(fas_vekt,1,N);

    k_noll = 2*pi/lambda_noll;
    E_k_obs = exp(1i*(fas+k_noll*r));

    E_obs = sum(E_k_obs,1);
    I_obs_inst = abs(E_obs).^2;
    
    instantan_produkt = E_obs(1)*conj(E_obs);
    instantana_produkter = [instantana_produkter; instantan_produkt]; % Sparar den instantana produkten av E
    
    I_obs_insts = [I_obs_insts; I_obs_inst]; % Sparar det instantana I
    
    instantan_produkt_I = I_obs_inst(1)*conj(I_obs_inst);
    instantana_produkter_I = [instantana_produkter_I; instantan_produkt_I]; % Sparar den instantana produkten av I
    
end






% Medelvärde, absolutbelopp, normering och plot av gamma_ab
gamma_ab = mean(instantana_produkter);
gamma_ab_norm_abs = abs(gamma_ab/gamma_ab(1));

figure(1)
plot(uvekt, gamma_ab_norm_abs)
ylim([0 1])
xlabel('u [m]')
ylabel('Normerat absolutbelopp av medelvärdet av \Gamma_{AB}', 'Interpreter', 'tex')
title('Mutual coherence function')

% Medelvärde, normering och plot av intensiteten
I_obs = mean(I_obs_insts);
I_obs_norm = I_obs/max(I_obs);

figure(2)
plot(uvekt, I_obs_norm)
ylim([0 1])
xlabel('u [m]')
ylabel('Normerat medelvärde av intensiteten', 'Interpreter', 'tex')
title('Intensitet')

% Skriv ut konstanten
l_s = 8.3; % Läses av från figur
const = l_s*D_star/(lambda_noll*L);
disp(['Constant: ', sprintf('%.4f', const)])

% Medelvärde, absolutbelopp, normering och plot av gamma_I
gamma_I = mean(instantana_produkter_I);
gamma_I_norm_abs = abs(gamma_I/gamma_I(1));

figure(3)
plot(uvekt, gamma_I_norm_abs)
ylim([0 1])
xlabel('u [m]')
ylabel('Normerat absolutbelopp av medelvärdet av \Gamma_{I}', 'Interpreter', 'tex')
title('Mutual coherence function (intensitet)')


