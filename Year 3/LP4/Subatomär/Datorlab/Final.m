%% Laddar in data
clc, clf, clear, close all
format long
data = [32.0    6.34E-1     0.45E-1;
        35.0    2.77E-1     0.20E-1;
        37.5    1.40E-1     0.10E-1;
        40.0    5.89E-2     0.35E-2;
        42.0    3.25E-2     0.30E-2;
        44.0    1.61E-2     0.10E-2;
        46.0    7.95E-3     0.80E-3;
        47.0    5.32E-3     0.50E-3;
        48.0    3.46E-3     0.25E-3;
        49.0    2.40E-3     0.25E-3;
        50.0    1.62E-3     0.15E-3;
        51.0    1.19E-3     0.10E-3;
        52.0    8.27E-4     0.40E-4;
        54.0    5.38E-4     0.40E-4;
        55.0    4.71E-4     0.50E-4;
        56.0    4.32E-4     0.30E-4;
        58.0    4.50E-4     0.45E-4;
        60.0    4.82E-4     0.30E-4;
        64.0    4.54E-4     0.30E-4;
        68.0    3.24E-4     0.25E-4;
        72.0    2.11E-4     0.15E-4;
        76.0    1.18E-4     0.10E-4;
        80.0    6.12E-5     0.40E-5;
        85.0    2.23E-5     0.15E-5;
        90.0    6.50E-6     0.45E-6;
        95.0    1.42E-6     0.10E-6;
        100.0   2.70E-7     0.35E-7;
        105.0   2.13E-7     0.25E-7;
        110.0   3.92E-7     0.45E-7;
        115.0   3.13E-7     0.55E-7;
        125.0   2.21E-7     0.30E-7];

%% Nödvändiga konstanter
theta = data(:,1);              %deg
crosssection = data(:,2)*1e-31; %m^2/sr
error = data(:,3)*1e-31;        %m^2/sr

Z_t = 20;
epsilon = 1e-6;
hbar = 1.05457160e-34;          %Js
e = 1.60217646e-19;             %C
alpha = 7.297352533e-3;
c = 299792458;                  %m/s
MeV = 1.6021765e-13;            %J
E = 250 .* MeV;                 %J
me = 9.1093819e-31;             %kg
beta = sqrt(1-me.^2*c.^4./E.^2);

v = beta.*c;                    %m/s
p = me.*v./(sqrt(1-beta.^2));   %kg*m*s;
q = 2.*p.*sind(theta./2);       %kg*m*s


%% Optimering
X0 = [1.1e25,4e-15,0.55e-15];
fun = @(X) chi_squared(X, theta, crosssection, error, hbar, Z_t, c, beta,...
        E, alpha, q, e) + ((Z_condition(X,e)- Z_t)./epsilon).^2;

options = optimset('PlotFcns',@optimplotfvallog, 'MaxFunEvals', 1e6, 'MaxIter',1e6);
tic
x = fminsearch(fun, X0,options);
toc

%% Plot 2a
thetaplot2a = linspace(20,130, 1000);  
theo = zeros(size(thetaplot2a));
qplot2a = 2.*p.*sind(thetaplot2a./2);

for i = 1:length(thetaplot2a)
    theo(i) = theo_crosssection(thetaplot2a(i), x, hbar, Z_t, c, beta, E, alpha, qplot2a(i), e);
end

figure(1)
clf
semilogy(theta, crosssection*1e31, 'rx', 'MarkerSize', 20)
hold on
semilogy(thetaplot2a, theo*1e31, 'LineWidth', 2)
xlabel('$\theta$ $(deg)$', 'Interpreter', 'latex')
ylabel('d$\sigma$/d$\Omega$ $(mb/sr)$', 'Interpreter', 'latex')
set(gca, 'FontSize', 22)
grid
set(gca,'YMinorTick','off')
legend('Experiment, Frosch et al', 'Teori baserad p\aa \ $\chi^2(\mathbf{X_\star})$', 'Interpreter', 'latex', 'Interpreter', 'latex')

%% Plot 2b
r_linspace = linspace(0,8e-15);
rho_linspace = rho_ch(r_linspace, x)*10^(-45)/e;

figure(2)
clf
hold on
area(r_linspace*10^15, rho_linspace, 'EdgeAlpha', 0)
plot(r_linspace*10^15, rho_linspace, 'LineWidth', 2, 'Color', 'black')
xlabel('$r$ $(fm)$', 'Interpreter', 'latex')
ylabel('$\rho$ $(e fm^{-3})$', 'Interpreter', 'latex')
set(gca, 'FontSize', 22)
box on

%% Skriver ut värden
r_rms = sqrt(4*pi/(Z_t*e)*integral(@(r) r.^4.*rho_ch(r,x), 0, 1e-13));
disp(strcat('r_rms =', {' '}, num2str(r_rms*10^15, '%.7f'), ' fm'))
disp(strcat('rho_ch =', {' '}, num2str(x(1)*10^-45/e, '%.7f'), ' e/fm^3'))
disp(strcat('a =', {' '}, num2str(x(2)*10^15, '%.7f'), ' fm'))
disp(strcat('b =', {' '}, num2str(x(3)*10^15, '%.7f'), ' fm'))
%% Nödvändiga funktioner
function chi = chi_squared(X, theta, crosssection, error, hbar, Z_t, c, beta, E, alpha, q, e)
    sum = 0;
    for i = 1:size(theta)
        theo = theo_crosssection(theta(i), X, hbar, Z_t, c, beta, E, alpha, q(i), e);
        sum = sum + ((theo - crosssection(i))./error(i)).^2;
    end
    chi = sum;
end

function theo = theo_crosssection(theta, X, hbar, Z_t, c, beta, E, alpha, q, e)
    mott = mott_crosssection(theta, hbar, Z_t, c, beta, E, alpha);
    F = form_factor(q, X, hbar, e, Z_t);
    theo = mott * (abs(F))^2;
end

function Z = Z_condition(X, e)
    syms r   
    Z_integral = 0;
    r = 0;
    dr = 1e-17;
    while r < 1e-13
        Z_integral = Z_integral + r.^2.*rho_ch(r, X).*dr;
        r = r + dr;
    end
   
    Z = 4*pi/e * Z_integral;
end

function rho = rho_ch(r, X)
    rho_ch_0 = X(1);
    a = X(2);
    b = X(3);
    rho = rho_ch_0./(1+exp((r-a)./b));
end

function mott = mott_crosssection(theta, hbar, Z_t, c, beta, E, alpha)
    thetarad = deg2rad(theta);
    mott = Z_t.^2 .* alpha.^2 .* hbar.^2 .* c.^2 ./ (4.*beta.^4.*E.^2.*...
        (sin(thetarad./2)).^4).* (1 - beta.^2.*(sin(thetarad./2)).^2);    
end

function F = form_factor(q, X, hbar, e, Z_t)
    syms r
    F_integral = 0;
    r = 0;
    dr = 1e-17;
    while r < 1e-13
        F_integral = F_integral + r.* rho_ch(r,X).*sin(q.*r./hbar).*dr;
        r = r + dr;
    end
    
    F = 4.*pi.*hbar./(Z_t.*e.*q).* F_integral;
    
end
