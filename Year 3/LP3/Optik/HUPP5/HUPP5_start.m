close all
clear

N=256;
sidlaengd_Plan1=100e-6;
omega_in=6e-6;
lambda_noll=1550e-9;
k_noll=2*pi/lambda_noll;
a=sidlaengd_Plan1/N;
delta_y = 0; %4.35e-6; för att få en faktor 2
alpha = 4/180*pi;

xvekt=-N/2*a:a:(N/2-1)*a;
yvekt=xvekt;
[xmat,ymat]=meshgrid(xvekt,yvekt);
rmat=sqrt(xmat.^2+ymat.^2);

yvektfalt = yvekt - delta_y; % skapar en ny y-vektor som används för att skapa ett förskjutet fält
[xmatfalt, ymatfalt] = meshgrid(xvekt, yvektfalt);

% brytningsindexvariation i (x,y)-led
n_core=1.51; % i kärnan
n_clad=1.50; % i höljet
D_core=60e-6;
nmat = nmat_GRIN(n_core, n_clad, D_core, xmatfalt, ymatfalt);%(rmat<=D_core/2)*n_core+(rmat>D_core/2)*n_clad;
figure(1)
imagesc(xvekt*1e6,yvekt*1e6,nmat)
xlabel('x [µm]')
ylabel('y [µm]')
colormap(jet)
colorbar
title('Brytningsindexvariation')
drawnow


% dämpmatris (behöver normalt inte ändras)
r_daemp_start=D_core/2; % ut till denna radie sker ingen dämpning
kantvaerde=0.8; % värdet på daempmat vid kanten av beräkningsfönstret (längs xy-axlarna)
daempmat=(rmat<=r_daemp_start)*1+(rmat>r_daemp_start).*(1-(1-kantvaerde)/(N/2*a-r_daemp_start)^2.*(rmat-r_daemp_start).^2);
daempmat(daempmat<0)=0;
figure(2)
mesh(xvekt*1e6,yvekt*1e6,daempmat)
xlabel('x [µm]')
ylabel('y [µm]')
title('Daempmat')
colormap(jet)
drawnow
disp('Tryck valfri tangent för att fortsätta!')
pause

% startfält "längst till vänster"
E_fundamental = exp(-(xmatfalt.^2+ymatfalt.^2)/omega_in^2);
% E_mode = E_fundamental.*ymatfalt.*5e5;

E_start = E_fundamental.*exp(1i*k_noll*sin(alpha)*ymatfalt);


% total propagationssträcka och BPM-steg-storlek
L=10000e-6;
delta_z=2e-6;
Lvekt=delta_z:delta_z:L;

E1=E_start;
E_sida=zeros(N,length(Lvekt));
I_sida_norm=zeros(N,length(Lvekt));
steg_nummer=0;
for akt_L=Lvekt
    steg_nummer=steg_nummer+1;
    
    E2=BPM_steg(E1,delta_z,N,a,lambda_noll,nmat,daempmat); % Fältfördelning i Plan 2
    
    I2=abs(E2).^2; % Intensitetsfördelning i Plan 2
    
    % Vektorer/matriser för plottning sett "från sidan"
    E2_laengs_yaxeln=E2(:,N/2+1);
    E_sida(:,steg_nummer)=E2_laengs_yaxeln;
    I2_laengs_yaxeln=abs(E2_laengs_yaxeln).^2;
    I2_laengs_yaxeln_norm=I2_laengs_yaxeln/max(I2_laengs_yaxeln);
    I_sida_norm(:,steg_nummer)=I2_laengs_yaxeln_norm;
    
    if steg_nummer <50 | rem(steg_nummer,5)==0 % för att snabba på simuleringen plottas inte alla BPM-steg
        
        figure(10)
        imagesc(xvekt*1e6,yvekt*1e6,I2)
        hold on
        plot(D_core/2*cos(linspace(0,2*pi,50))*1e6,D_core/2*sin(linspace(0,2*pi,50))*1e6,'Color',[1 1 1]*0.6,'LineWidth',2)
        title(['Intensitet i tvärsnitt efter ' num2str(akt_L*1e3) ' mm propagation' ])
        axis('square')
        xlabel('x [µm]')
        ylabel('y [µm]')
        colormap(jet)
        hold off
        drawnow
        %pause
        
        
        figure(11)
        imagesc(Lvekt*1e3,yvekt*1e6,I_sida_norm)
        title(['I_-sida: Normerad intensitet efter ' num2str(akt_L*1e3) ' mm propagation' ])
        xlabel('z [mm]')
        ylabel('y [µm]')
        colormap(jet)
        drawnow
        %pause
        
    end
    
    E1=E2;
end

disp(max(max(I2)))

