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
data(:,2) = data(:,2).*1e-31;
data(:,3) = data(:,3).*1e-31;
semilogy(data(:,1), data(:,2))
%%
% Storheter tagna från Physics Handbbok
Zp = 1;
Zt = 20;
eps_0 = 8.8541878128e-12; % F/m
e = 1.602176634e-19; % C
hbar = 6.62607015e-34/(2*pi); % Js
c = 299792458;  % m/s
alpha = 1/(4*pi*eps_0)*e^2/(hbar*c);
E_tot = 249.5e6*1.60218e-19; %J
m_rest = 8.1871057769e-14; % J
m_e = 9.1093837015e-31; %Kg
gamma = E_tot/m_rest;
p = sqrt(E_tot^2-m_e^2*c^4)/c;
betaFactor = sqrt(1-1/gamma^2);

Pch = @(r,X) X(1)./( 1 + exp( (r-X(2))./X(3) ));

% Frosch
Pch = @(r,X) (X(1))./( 1 + exp( (r-X(2))./X(3) ));

dSig_dOhm_Mott = @(theta) (Zp.*Zt.*alpha.*hbar.*c).^2./(4.*betaFactor.^4.*E_tot.^2.*sin(theta./2).^4).*(1-betaFactor.^2.*sin(theta./2).^2);



ChiFunFinal = @(X) ChiFun(X,data);

options = optimset('PlotFcns',@optimplotfvallog,'MaxFunEvals',10000000);
%Xfinal = [1.190668790282582e+25,3.767897310308469e-15,5.377640555285364e-16]
Xfinal = fminsearch(ChiFunFinal,[1.190668790282582e+25,3.767897310308469e-15,5.377640555285364e-16],options)

%%

Pch = @(r,X) X(1)./( 1 + exp( (r-X(2))./X(3) ));
dr = 0.0001e-15;
sum = 0;
r = 0;
Xtemp = Xfinal;
 while true
     dSum = r.^4.*Pch(r,Xtemp).*dr;
     
     sum = sum + dSum;
     
     r = r + dr;
     
     if r > 100e-15
        break; 
     end
     
 end


rms = sqrt(sum.*4.*pi/(Zt.*e)).*1e15

%%
clf; clc;
theta = data(:,1).*pi./180; 
plot(theta*180/pi,data(:,2),'bo','MarkerFaceColor', 'b')
set(gca, 'YScale', 'log')
hold on;
x = 0:0.01:3;
plot(x*180/pi,dSig_dOhm_Mott(x).*abs(F(x,Xfinal)).^2.*1e31,'color','k','lineWidth',2)
yticks([10^(-8) 10^(-5) 10^(-2) 10^(1)])
xticks([40 60 80 100 120])
axis([25 130 10^(-8) 10])
xlabel('$\theta$ (deg)','interpreter','latex')
ylabel('$d\sigma/d\Omega$ (mb/sr) ','interpreter','latex')
grid on;

%%
clf; clc;
r = 0:0.01e-15:8e-15;
plot(r/(1e-15),Pch(r,Xfinal)/(e/(1e-15)^3),'color','k','lineWidth',2)
hold on;
area(r/(1e-15),Pch(r,Xfinal)/(e/(1e-15)^3),'facecolor','b','facealpha',0.25)
yticks([0.00 0.02 0.04 0.06])
xticks([0 2 4 6 8])
axis([0. 8 0 0.08])
xlabel('$r$ (fm)','interpreter','latex')
ylabel('$\rho$ (e fm$^{-3}$) ','interpreter','latex')

%% Froesch Et.al
