%% 3.a
a1 = 5 + 11i; a2 = 5 - 11i;
a3 = 7.5 + 16i; a4 = 7.5 - 16i;
alpha = 7.55;
beta = sqrt(75.85);
d = 0.18; %m
g = 9.81; %m/s^2
s=tf('s');

Tf = 1/(a1+a2+a3+a4);

Ki = (a1*a2*a3*a4*Tf)/alpha;

Kp = (((a4*(a1*a2+a3*(a1+a2))+a1*a2*a3)*Tf+beta^2)/alpha) - Ki*Tf;

Kd = ((a1*a2+a4*(a1+a2+a3)+a3*(a1+a2))*Tf + Tf*beta^2)/alpha - Kp*Tf;

FG = (((s*Kp+Ki)*(1+s*Tf))+Kd*s^2)/(s*(s*Tf+1))*(alpha/(s^2-beta^2));

Gp = -((FG/(1+FG))*((d*s^2 - g)/s));

bode(Gp)
grid on
%% 3.b

wc=0.75;
[gpmag, gpphasedeg] = bode(Gp, wc)
gpmag
gpphase=(gpphasedeg)*pi/180

Ti=-1/(wc*tan(-120*pi/180-gpphase));
Fvmag = 1/gpmag;
Kp = Fvmag/(sqrt(1+(1/(Ti*wc)^2)))
Ki = Kp/Ti

Fv = (Kp + Ki/s);

%%
clf
L=Fv*Gp;
bode(L)
grid on

[Lmag, Lphasedeg] = bode(L, wc);
phaseMargin = Lphasedeg + 180
