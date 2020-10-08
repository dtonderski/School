function [funktion_2D, uvekt, vvekt, umat, vmat]=Sampla_om_radiell_till_2D(funktion_radiell, u_eval_vekt, N_2D, samplavst_2D)

% Inparametrar
% funktion_radiell: den radiellt samplade funktionen...
% u_eval_vekt: ... och vektorn med radiella positionerna där den är samplad
% N_2D: 2D-matrisen har matrisstorleken N_2D x N_2D ...
% samplavst_2D: ... med detta samplingsavstånd 


uvekt=-N_2D/2*samplavst_2D:samplavst_2D:(N_2D/2-1)*samplavst_2D; 
vvekt=uvekt; % och y-led
[umat,vmat]=meshgrid(uvekt,vvekt); 
rmat_uv=sqrt(umat.^2+vmat.^2);

funktion_2D=interp1(u_eval_vekt,funktion_radiell,rmat_uv,'linear',0);




