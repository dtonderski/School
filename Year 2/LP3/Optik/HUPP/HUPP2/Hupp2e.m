clear all; clc;
E_in = J_proj(pi/2)*[1;0];
%% R -> R
J_ret0 = J_proj(pi/2)*J_ret(pi/4, 1.25*pi/2);
J_ret1 = J_proj(pi/2)*J_ret(-pi/4, 1.25*pi/2);
J_pol1 = J_pol(0);
E_ut1 = J_pol1*J_ret1*J_ret0*E_in
I_1 = (abs(E_ut1(1)))^2 + (abs(E_ut1(2)))^2
%% R -> L
J_ret0 = J_proj(pi/2)*J_ret(pi/4, 1.25*pi/2);
J_ret1 = J_proj(pi/2)*J_ret(pi/4, 1.25*pi/2);
J_pol1 = J_pol(0);
E_ut2 = J_pol1*J_ret1*J_ret0*E_in
I_2 = (abs(E_ut2(1)))^2 + (abs(E_ut2(2)))^2
%% L -> R
J_ret0 = J_proj(pi/2)*J_ret(-pi/4, 1.25*pi/2);
J_ret1 = J_proj(pi/2)*J_ret(-pi/4, 1.25*pi/2);
J_pol1 = J_pol(0);
E_ut3 = J_pol1*J_ret1*J_ret0*E_in
I_3 = (abs(E_ut3(1)))^2 + (abs(E_ut3(2)))^2
%% L -> L
J_ret0 = J_proj(pi/2)*J_ret(-pi/4, 1.25*pi/2);
J_ret1 = J_proj(pi/2)*J_ret(pi/4, 1.25*pi/2);
J_pol1 = J_pol(0);
E_ut4 = J_pol1*J_ret1*J_ret0*E_in
I_4 = (abs(E_ut4(1)))^2 + (abs(E_ut4(2)))^2
