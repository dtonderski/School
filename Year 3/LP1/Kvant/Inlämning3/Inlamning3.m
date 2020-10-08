clear,clc, clf
m = 9.11e-31; %elektronens massa
hbar = 1.05e-34;
sig = 5.2e-11; %Bohrs radius
%% Uppgift 1
x=linspace(-10*sig, 10*sig); %såg bra ut så här, man ser fördelningens tidsutveckling på ett bra sätt

%Plottar absolutbeloppet av PsiG i en viss tidpunkt
subplot(2,2,1)
t=0;
PsiG = 1./sqrt(sig*sqrt(2*pi))*sig./sqrt(sig^2+1i*hbar.*t./(2*m)).*exp(-(x).^2./(4*(sig^2+1i*hbar.*t./(2*m))));
plot(x,abs(PsiG).^2)
title('t = 0 s','Interpreter','latex')


subplot(2,2,2)
t=1e-16;
PsiG = 1./sqrt(sig*sqrt(2*pi))*sig./sqrt(sig^2+1i*hbar.*t./(2*m)).*exp(-(x).^2./(4*(sig^2+1i*hbar.*t./(2*m))));
plot(x,abs(PsiG).^2)
title('t = $1\cdot10^{-16}$ s','Interpreter','latex')


subplot(2,2,3)
t=2e-16;
PsiG = 1./sqrt(sig*sqrt(2*pi))*sig./sqrt(sig^2+1i*hbar.*t./(2*m)).*exp(-(x).^2./(4*(sig^2+1i*hbar.*t./(2*m))));
plot(x,abs(PsiG).^2)
title('t = $2\cdot10^{-16}$ s','Interpreter','latex')

subplot(2,2,4)
t=1;
PsiG = 1./sqrt(sig*sqrt(2*pi))*sig./sqrt(sig^2+1i*hbar.*t./(2*m)).*exp(-(x).^2./(4*(sig^2+1i*hbar.*t./(2*m))));
plot(x,abs(PsiG).^2)
title('t = 1 $(\approx \infty)$ s','Interpreter','latex')

%Lite estetiska saker
for i=[1:4]
    subplot(2,2,i)
    ylim([-5e8 9e9])
    xlabel('Position [m]','Interpreter','latex')
    ylabel('$|\Psi_G|^2$','Interpreter','latex')
    set(gca,'FontSize',15)
end


%%
a= 3*sig; %random, storleksordning runt 5*sigma 
x=[-2*a:a/40:2*a]; %för att se dubbelt så långt som avståndet mellan hålen i x-axeln
y = [0:a/80:2*a];  %verkade enklast att ta samma som x, värdet på t anpassas ändå genom v
v = 5e5; %det som funkar (man ser att fördelningen ändras i y-axeln, men inte så snabbt att man bara ser t=0 och sen en konstant fördelning)

[X, Y] = meshgrid(x,y);

PsiGminusa = 1./sqrt(sig*sqrt(2*pi))*sig./sqrt(sig^2+1i*hbar.*Y./(2*m*v)).*exp(-(X-a).^2./(4*(sig^2+1i*hbar.*Y./(2*m*v))));
PsiGplusa  = 1./sqrt(sig*sqrt(2*pi))*sig./sqrt(sig^2+1i*hbar.*Y./(2*m*v)).*exp(-(X+a).^2./(4*(sig^2+1i*hbar.*Y./(2*m*v))));

figure(2)
surf(X, Y, abs(PsiGminusa+PsiGplusa).^2)
xlabel('Position (x) [m]','Interpreter','latex')
ylabel('Position (y) [m]','Interpreter','latex')
zlabel('$|\Psi_G|^2$','Interpreter','latex')
set(gca,'FontSize',15)

figure(3)
contour(X, Y, abs(PsiGminusa+PsiGplusa).^2)
xlabel('Position (x) [m]','Interpreter','latex')
ylabel('Position (y) [m]','Interpreter','latex')
zlabel('$|\Psi_G|^2$','Interpreter','latex')
set(gca,'FontSize',15)

%%
syms x y a;
PsiGminusasym = 1./(1+1i*y).*exp(-(x-a).^2./(4*(1+1i.*y)));
PsiGplusasym = 1./(1+1i*y).*exp(-(x+a).^2./(4*(1+1i.*y)));

%absolutbeloppet i kvadrat = Psi * conj(Psi). abs() leder till konstiga resultat
Psigabssquared = (PsiGminusasym + PsiGplusasym)*conj(PsiGminusasym + PsiGplusasym);
PsiGdiff = diff(Psigabssquared,x);
PsiGdiffdiff = diff(PsiGdiff,x);
%satter x=0
x=0;

%visar förstaderivatan för x=0
disp(subs(PsiGdiff))

%plottar andraderivatan om x=0 som funktion av y. Intervallet av a och av y
%hittades manuellt (hela den intressanta delen synlig)
figure(4)
fsurf(subs(PsiGdiffdiff), [0 4 0 4])
xlabel('Position y')
ylabel('Avstånd a')
set(gca,'FontSize',15)





