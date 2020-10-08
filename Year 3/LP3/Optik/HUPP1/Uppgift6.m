clear
close all
%full_white_value=64; % äldre matlabversion - detta värde plottas som vitt (max) med image-kommandot
full_white_value=255; % nyare matlabversion - prova denna om din plot verkar mörk!

N=1024; % NxN är matrisstorleken (rekommenderad storlek N=1024)
sidlaengd_Plan1=4e-3; % det samplade områdets storlek (i x- eller y-led) i Plan 1 (rekommenderad storlek 4 mm)
a=sidlaengd_Plan1/N; % samplingsavstånd i Plan 1 (och Plan 2 eftersom vi använder PAS)
L=20e-3; % propagationssträcka (dvs avstånd mellan Plan 1 och 2)

lambda_noll=633e-9; % vakuumvåglängd för rött ljus från en HeNe-laser
n_medium=1; % brytningsindex för medium mellan Plan 1 och 2
k = 2*pi*n_medium/lambda_noll; % k-vektorns längd

xvekt=-N/2*a:a:(N/2-1)*a; % vektor med sampelpositioner i x-led
yvekt=xvekt; % och y-led
[xmat,ymat]=meshgrid(xvekt,yvekt); % koordinatmatriser med x- och y-värdet i varje sampelposition
rmat=sqrt(xmat.^2+ymat.^2); % avståndet till origo i varje sampelpunkt. Observera att alla operationer är elementvisa!
load T_DOE_gen2; % laddar in transmissionsfunktionen för DOEn
%% UTAN DE VISES LINS
clf,clc
f_lins=20e-3; % fokallängd på linsen i ogat
T_lins=exp(-1i*k*rmat.^2/(2*f_lins)); % transmissionsfunktion för en lins (linsen ar TOK)
E_in=ones(N,N); % infallande fält: Plan våg med normalt infall
E_ut=E_in.*T_lins.*T_DOE_gen2;
E2=PAS(E_ut,L,N,a,lambda_noll,n_medium); % propagation med PAS-funktionen
I2=abs(E2).^2; % Intensiteten

mattnadsfaktor_plot=10000; % anger hur många gånger maxvärdet ska vara mättat i plotten (>1, kan vara bra om man vill se svagare detaljer)
figure(3)
image(xvekt*1e3,yvekt*1e3,I2/max(max(I2))*full_white_value*mattnadsfaktor_plot)
xlabel('x[mm]')
ylabel('y[mm]')
colormap(gray)
drawnow
axis('equal')
%% MED DE VISES LINS
clf, clc
f_lins=20e-3; % fokallängd på linsen i ogat
f_lins_v=1.43e-1; % fokallängd på de vises lins
T_lins=exp(-1i*k*rmat.^2/(2*f_lins)); % Transmissionsfunktion för en lins (linsen ar TOK)
T_lins_v=exp(-1i*k*rmat.^2/(2*f_lins_v));
E_in=ones(N,N); % Infallande falt: Plan våg med normalt infall
E_ut=E_in.*T_lins.*T_DOE_gen2.*T_lins_v;
E2=PAS(E_ut,L,N,a,lambda_noll,n_medium); % Propagation med PAS-funktionen
I2=abs(E2).^2; % Intensiteten

mattnadsfaktor_plot=15; % anger hur många gånger maxvärdet ska vara mättat i plotten (>1, kan vara bra om man vill se svagare detaljer)
figure(4)
image(xvekt*1e3,yvekt*1e3,I2/max(max(I2))*full_white_value*mattnadsfaktor_plot)
xlabel('x[mm]')
ylabel('y[mm]')
colormap(gray)
drawnow
camroll(180)
axis('equal')
