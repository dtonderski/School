clear
close all
load T_DOE_gen2;

N=1024; % NxN �r matrisstorleken
sidlaengd_Plan1=4e-3; % det samplade omr�dets storlek (i x- eller y-led)
a=sidlaengd_Plan1/N; % samplingsavst�nd i Plan 1 (och Plan 2 eftersom vi anv�nder PAS)
L=20e-3; % propagationsstr�cka (dvs avst�nd mellan Plan 1 och 2)

lambda_noll=633e-9; % vakuumv�gl�ngd f�r r�tt ljus fr�n en HeNe-laser
n_medium=1; % brytningsindex f�r medium mellan Plan 1 och 2
k=2*pi*n_medium/lambda_noll; % k-vektorns l�ngd *** Klar

xvekt=-N/2*a:a:(N/2-1)*a; yvekt=xvekt; % vektor med sampelpositioner i x- och y-led
[xmat,ymat]=meshgrid(xvekt,yvekt); % koordinatmatriser med x- och y-v�rdet i varje sampelposition
rmat=sqrt(xmat.^2+ymat.^2); % avst�ndet till origo i varje sampelpunkt.
%% UTAN DE VISES LINS
clf,clc
f_lins=20e-3; % fokall�ngd p� linsen i �gat
T_lins=exp(-1i*k*rmat.^2/(2*f_lins)); % Transmissionsfunktion f�r en lins (linsen �r TOK)

E_in=ones(N,N); % Infallande f�lt: Plan v�g med normalt infall

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
f_lins=20e-3; % fokall�ngd p� linsen i �gat
f_lins_v=1.44e-1; % fokall�ngd p� de vises lins

T_lins=exp(-1i*k*rmat.^2/(2*f_lins)); % Transmissionsfunktion f�r en lins (linsen �r TOK)
T_lins_v=exp(-1i*k*rmat.^2/(2*f_lins_v));

E_in=ones(N,N); % Infallande f�lt: Plan v�g med normalt infall

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