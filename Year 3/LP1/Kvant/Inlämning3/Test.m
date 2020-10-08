clear,clc, clf
m = 1; %elektronens massa
hbar = 2;
sig = 1; %Bohrs radius
%% Uppgift 1
a= 3; %random, storleksordning runt 5*sigma 
x=[-10:0.1:10]; %för att se dubbelt så långt som avståndet mellan hålen i x-axeln
y = [0:0.1:10];  %verkade enklast att ta samma som x, värdet på t anpassas ändå genom v
[X, Y] = meshgrid(x,y);

PsiGminusa = 1./(1+1i*Y).*exp(-(X-a).^2./(4*(1+1i.*Y)));
PsiGplusa = 1./(1+1i*Y).*exp(-(X+a).^2./(4*(1+1i.*Y)));

figure(1)
surf(X, Y, abs(PsiGminusa+PsiGplusa).^2)
xlabel('Position (x) [m]','Interpreter','latex')
ylabel('Position (y) [m]','Interpreter','latex')
zlabel('$|\Psi_G|^2$','Interpreter','latex')
set(gca,'FontSize',15)

%%
syms x y;
PsiGminusasym = 1./(1+1i*y).*exp(-(x-a).^2./(4*(1+1i.*y)));
PsiGplusasym = 1./(1+1i*y).*exp(-(x+a).^2./(4*(1+1i.*y)));

%absolutbeloppet i kvadrat = Psi * conj(Psi). abs() leder till konstiga resultat
Psigabssquared = (PsiGminusasym + PsiGplusasym)*conj(PsiGminusasym + PsiGplusasym);
PsiGdiff = diff(Psigabssquared,x);
PsiGdiffdiff = diff(PsiGdiff,x);
x=0;

%visar värdet av förstaderivatan för x=0
disp(subs(PsiGdiff))

%plottar värdet av andraderivatan för x=0 som funktion av y. Intervallet
%för y hittades manuellt
fplot(subs(PsiGdiffdiff), [0 10])


