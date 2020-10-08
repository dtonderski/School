clear
close all
load T_DOE_gen2;

N=1024; % NxN är matrisstorleken
sidlaengd_Plan1=4e-3; % det samplade områdets storlek (i x- eller y-led)
a=sidlaengd_Plan1/N; % samplingsavstånd i Plan 1 (och Plan 2 eftersom vi använder PAS)
L=20e-3; % propagationssträcka (dvs avstånd mellan Plan 1 och 2)

lambda_noll=633e-9; % vakuumvåglängd för rött ljus från en HeNe-laser
n_medium=1; % brytningsindex för medium mellan Plan 1 och 2
k=2*pi*n_medium/lambda_noll; % k-vektorns längd *** Klar

xvekt=-N/2*a:a:(N/2-1)*a; yvekt=xvekt; % vektor med sampelpositioner i x- och y-led
[xmat,ymat]=meshgrid(xvekt,yvekt); % koordinatmatriser med x- och y-värdet i varje sampelposition
rmat=sqrt(xmat.^2+ymat.^2); % avståndet till origo i varje sampelpunkt.
%% UTAN DE VISES LINS
clf,clc
f_lins=20e-3; % fokallängd på linsen i ögat
T_lins=exp(-1i*k*rmat.^2/(2*f_lins)); % Transmissionsfunktion för en lins (linsen är TOK)

E_in=ones(N,N); % Infallande fält: Plan våg med normalt infall

E_ut=E_in.*T_lins.*T_DOE_gen2;

E2=PAS(E_ut,L,N,a,lambda_noll,n_medium); % Propagation med PAS-funktionen
I2=abs(E2).^2; % Intensiteten



mattnadsfaktor_plot=10000;
figure(3)
image(xvekt*1e3,yvekt*1e3,I2/max(max(I2))*64*mattnadsfaktor_plot)
colormap(gray) 
drawnow
axis('equal')
%% MED DE VISES LINS
clf, clc
f_lins=20e-3; % fokallängd på linsen i ögat
f_lins_v=1.44e-1; % fokallängd på de vises lins

T_lins=exp(-1i*k*rmat.^2/(2*f_lins)); % Transmissionsfunktion för en lins (linsen är TOK)
T_lins_v=exp(-1i*k*rmat.^2/(2*f_lins_v));

E_in=ones(N,N); % Infallande fält: Plan våg med normalt infall

E_ut=E_in.*T_lins.*T_DOE_gen2.*T_lins_v;

E2=PAS(E_ut,L,N,a,lambda_noll,n_medium); % Propagation med PAS-funktionen
I2=abs(E2).^2; % Intensiteten

mattnadsfaktor_plot=100;
figure(3)
image(xvekt*1e3,yvekt*1e3,I2/max(max(I2))*64*mattnadsfaktor_plot)
colormap(gray) 
drawnow
axis('equal')
camroll(-90)