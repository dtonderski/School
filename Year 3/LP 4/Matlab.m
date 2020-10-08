%%
clear all, clc, clf, clear, close all
data = [32.0 6.34E-1 0.45E-1;35.0 2.77E-1 0.20E-1;37.5 1.40E-1 0.10E-1;40.0 5.89E-2 0.35E-2
42.0 3.25E-2 0.30E-2;44.0 1.61E-2 0.10E-2;46.0 7.95E-3 0.80E-3;47.0 5.32E-3 0.50E-3
48.0 3.46E-3 0.25E-3;49.0 2.40E-3 0.25E-3;50.0 1.62E-3 0.15E-3;51.0 1.19E-3 0.10E-3
52.0 8.27E-4 0.40E-4;54.0 5.38E-4 0.40E-4;55.0 4.71E-4 0.50E-4;56.0 4.32E-4 0.30E-4
58.0 4.50E-4 0.45E-4;60.0 4.82E-4 0.30E-4;64.0 4.54E-4 0.30E-4;68.0 3.24E-4 0.25E-4
72.0 2.11E-4 0.15E-4;76.0 1.18E-4 0.10E-4;80.0 6.12E-5 0.40E-5;85.0 2.23E-5 0.15E-5
90.0 6.50E-6 0.45E-6;95.0 1.42E-6 0.10E-6;100.0 2.70E-7 0.35E-7;105.0 2.13E-7 0.25E-7
110.0 3.92E-7 0.45E-7;115.0 3.13E-7 0.55E-7;125.0 2.21E-7 0.30E-7];
semilogy(data(:,1), data(:,2))
%%
Z_t = 20;
epsilon = 1e-6;
theta = data(:,1);
crosssection = data(:,2);
error = data(:,3);

fun = @(X) chi_squared(X, theta, crosssection, error) + ((Z_condition(X) - Z_t)./epsilon).^2;
%%
X0 = [1.1e25,4e-15,0.55e-15];
tic
x = fminsearch(fun, X0);
toc

% %%
% clc
% X = [2.515e25,5.33e-15,0.523e-15];
% Z_condition(X)
% %%
% test = linspace(0, 5e-14);
% e = 1.60217662e-19; %C
% testy =  4*pi/e*test.^2.*rho_ch(test, X);
% plot(test,testy)
% Z = 4*pi/e * integral(@(r) r.^2.*rho_ch(r, X), 0, 1e-13)
%%
clf
e = 1.60217662e-19; %C
r_linspace = linspace(0,8e-15);
rho_linspace = rho_ch(r_linspace, x)*10^(-45)/e;
plot(r_linspace, rho_linspace)

figure(2)
thetatest = linspace(32,125, 100);  
theo = zeros(size(thetatest));
for i = 1:length(thetatest)
    theo(i) = theo_crossection(thetatest(i), x);
end
semilogy(theta, crosssection, 'rx')
hold on
semilogy(thetatest, theo)
%%
r_rms = sqrt(4*pi/(Z_t*e)*integral(@(r) r.^4.*rho_ch(r,x), 0, 1e-13))