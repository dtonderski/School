clear all; clc
E_in = [1;0]; %Anta positivt x till v�nster
%%
J_ret0 = J_ret(-pi/4, pi/2); %"-" eftersom den tr�ffer retarderaren bakifr�n
J_spegel = [-1 0; 0 1]; %Inverterar x-komponenten av ljuset (som studsar)
J_ret1 = J_ret(pi/4, pi/2); %Nu tr�ffar den retarderaren fr�n "r�tt" h�ll
J_pol1 = J_pol(0);
E_ut = J_pol1*J_ret1*J_spegel*J_ret0*E_in