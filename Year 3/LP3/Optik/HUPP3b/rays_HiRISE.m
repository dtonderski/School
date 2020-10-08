close all
clear

c_4=input('Ange c_4-koefficienten [0]');
if isempty(c_4)
    c_4=0;
end    
    
D_lins=.5;
L=3;
f_lins=L;
lambda=600e-9;
number_of_rays=20;
draw_rays=1;

k=2*pi/lambda;

% Linsens fasmodulering, c_2-värdet
c_2=-k/(2*f_lins);


% Rita strålar
y_rays=linspace(-D_lins/2,D_lins/2,number_of_rays+1);
dfidy=2*c_2*y_rays+4*c_4*y_rays.^3;
k_y=dfidy;
propvinkel=asin(k_y/k);
L_rays=1.1*f_lins;
y_rays_prop=y_rays+L_rays*tan(propvinkel);
figure(301)
plot([zeros(1,length(y_rays)) ; L_rays*ones(1,length(y_rays))],[y_rays; y_rays_prop]*100)
hold on
plot([f_lins f_lins],[-D_lins/2 D_lins/2]*100,'k--')
xlabel(['z [m]'])
ylabel(['y [cm]'])
title(['Strålgång i HiRISE, spegelns c_4=' num2str(c_4) ' m^{-4}'])
y_zoom_min=-0.04*1e-1;
y_zoom_max=abs(y_zoom_min);
z_zoom_min=3-5*1e-2;
z_zoom_max=3+5*1e-2;
%plot([z_zoom_min z_zoom_max z_zoom_max z_zoom_min z_zoom_min],[y_zoom_min y_zoom_min y_zoom_max y_zoom_max y_zoom_min]*100,'r' )
figure(302)
plot([zeros(1,length(y_rays)) ; L_rays*ones(1,length(y_rays))],[y_rays; y_rays_prop]*100)
hold on
plot([f_lins f_lins],[-D_lins/2 D_lins/2]*100,'k--')
xlabel(['z [m]'])
ylabel(['y [cm]'])
title('inzoomning nära fokus i figur 301')
axis([z_zoom_min z_zoom_max y_zoom_min*100 y_zoom_max*100]);

