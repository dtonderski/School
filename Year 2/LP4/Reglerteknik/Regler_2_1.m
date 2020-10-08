g = 9.81; d = 0.180; r = 0.049; K_m = 0.155; K_u = 0.3078; m = 0.38; M = 0.97; R_a = 2.4;

C = [1 0 0]
A = [0 1 0; g*(1+m/M)/d 0 0; g*m/M 0 0]
B = [0; K_m/(r*R_a*M*d); K_m/(r*R_a*M)]
s=tf('s');

G = C*inv(s*eye(3)-A)*B