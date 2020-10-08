%% Kvantinlämning 2
clf,clc,clear
%% Konstanter
hbar = 1.0545718e-34;
m = 9.10938356e-31;
% positioner
a1 = 0.3;    % 0.3nm
a2 = 0.75;   % 0.75nm
% potentialer
eV = 1.60217662e-19;
V1 = 0.1;
V2 = 0.3;

%% Del 1.1
clf
E = 0.2;
L = 0.5;
x =linspace(-5,7,1000);
n=1;
V=zeros(1,1000);
for j=x
    if 0<=j && j<a1
        V(n)=V1;
    elseif a1+L<=j && j<a1+a2+L
        V(n)=V2;
    else
        V(n)=0;
    end
    n=n+1;
end


plot(x,V,x,E*ones(1,1000),'--'), hold on
xlabel('Avstånd [nm]');
ylabel('Energi [eV]');
ylim([0 0.35]);

%% Del 1.2
clf
% avstånd
a1 = 0.3e-9;    % 0.3   nm
a2 = 0.75e-9;   % 0.75  nm
L = 0.5e-9;     % 0.5   nm

x =linspace(-5e-9,7e-9,1000);

% energier
eV = 1.60217662e-19;
V1 = 0.1*eV;
V2 = 0.3*eV;
E = 0.2*eV;

for j=x
    if 0<=j && j<a1
        V(n)=V1;
    elseif a1+L<=j && j<a1+a2+L
        V(n)=V2;
    else
        V(n)=0;
    end
    n=n+1;
end

k0 = sqrt(2*m*E)/hbar;
k1 = sqrt(2*m*(E-V1))/hbar;
k2 = sqrt(2*m*(V2-E))/hbar;
M1 = [1 1 ; k0 -k0];   
M2 = [1 1 ; k1 -k1];
M3 = [exp(1i*k1*a1) exp(-1i*k1*a1);...
    1i*k1*exp(1i*k1*a1) -1i*k1*exp(-1i*k1*a1)];
M4 = [exp(1i*k0*a1) exp(-1i*k0*a1);...
    1i*k0*exp(1i*k0*a1) -1i*k0*exp(-1i*k0*a1)];
M5 = [exp(1i*k0*(a1+L)) exp(-1i*k0*(a1+L));...
    1i*k0*exp(1i*k0*(a1+L)) -1i*k0*exp(-1i*k0*(a1+L))];
M6 = [exp(k2*(a1+L)) exp(-k2*(a1+L));...
    k2*exp(k2*(a1+L)) -k2*exp(-k2*(a1+L))];
M7 = [exp(k2*(a1+a2+L)) exp(-k2*(a1+a2+L));...
    k2*exp(k2*(a1+a2+L)) -k2*exp(-k2*(a1+a2+L))];
M8 = [exp(1i*k0*(a1+a2+L)) exp(-1i*k0*(a1+a2+L));...
    1i*k0*exp(1i*k0*(a1+a2+L)) -1i*k0*exp(-1i*k0*(a1+a2+L))];

P=inv(M1)*M2*inv(M3)*M4*inv(M5)*M6*inv(M7)*M8;

1/abs(P(1,1))^2
   

Psi1 = [1; P(2,1)/P(1,1)];
Psi2 = (inv(M1)*M2)\Psi1;
Psi3 = (inv(M1)*M2*inv(M3)*M4)\Psi1;
Psi4 = (inv(M1)*M2*inv(M3)*M4*inv(M5)*M6)\Psi1;
Psi5 = [1/P(1,1); 0];
figure(2)

Psirel= zeros(1,length(x));


t=0;n=1;
for j=x
    if j<0
        Psirel(n)=real((Psi1(1)*exp(1i*k0*j)+Psi1(2)*exp(-1i*k0*j))*exp(-1i*E*t/hbar));
    elseif  0<=j && j<a1
        Psirel(n)=real((Psi2(1)*exp(1i*k1*j)+Psi2(2)*exp(-1i*k1*j))*exp(-1i*E*t/hbar));
    elseif a1<=j && j<a1+L
        Psirel(n)=real((Psi3(1)*exp(1i*k0*j)+Psi3(2)*exp(-1i*k0*j))*exp(-1i*E*t/hbar));
    elseif a1+L<=j && j<a1+a2+L
        Psirel(n)=real((Psi4(1)*exp(k2*j)+Psi4(2)*exp(-k2*j))*exp(-1i*E*t/hbar));
    else 
        Psirel(n)=real((Psi5(1)*exp(1i*k0*j)+Psi5(2)*exp(-1i*k0*j))*exp(-1i*E*t/hbar));
    end
    n=n+1;
end

plot(x,Psirel), hold on
plot([0 0],[-3 3],'r--',[0 0],[-3 3],'r--',[a1 a1],[-3 3],'r--',[a1+L a1+L],[-3 3],'r--',[a1+L+a2 a1+L+a2],[-3 3],'r--')
hold off

axis([-5e-9 7e-9 -2.5 2.5])
xlabel('Avstånd [m]')
ylabel('Vågfunktion')


%% Del 2

T=zeros(100);
ep=1e-3*eV; %nollskild för att undvika T = NaN

j=1;
for E= linspace(ep,2*eV,100)
    l=1;
    
k0 = sqrt(2*m*E)/hbar;
k1 = sqrt(2*m*(E-V1))/hbar;
k2 = sqrt(2*m*(V2-E))/hbar;
    for L= linspace(0,1e-9,100)
        
        M1 = [1 1 ; k0 -k0];   
        M2 = [1 1 ; k1 -k1];
        M3 = [exp(1i*k1*a1) exp(-1i*k1*a1);...
            1i*k1*exp(1i*k1*a1) -1i*k1*exp(-1i*k1*a1)];
        M4 = [exp(1i*k0*a1) exp(-1i*k0*a1);...
            1i*k0*exp(1i*k0*a1) -1i*k0*exp(-1i*k0*a1)];
        M5 = [exp(1i*k0*(a1+L)) exp(-1i*k0*(a1+L));...
            1i*k0*exp(1i*k0*(a1+L)) -1i*k0*exp(-1i*k0*(a1+L))];
        M6 = [exp(k2*(a1+L)) exp(-k2*(a1+L));...
            k2*exp(k2*(a1+L)) -k2*exp(-k2*(a1+L))];
        M7 = [exp(k2*(a1+a2+L)) exp(-k2*(a1+a2+L));...
            k2*exp(k2*(a1+a2+L)) -k2*exp(-k2*(a1+a2+L))];
        M8 = [exp(1i*k0*(a1+a2+L)) exp(-1i*k0*(a1+a2+L));...
            1i*k0*exp(1i*k0*(a1+a2+L)) -1i*k0*exp(-1i*k0*(a1+a2+L))];

        P=inv(M1)*M2*inv(M3)*M4*inv(M5)*M6*inv(M7)*M8;

        T(j,l)=1/abs(P(1,1))^2;
        l=l+1;

    end
    j=j+1;
end

Tequalsone = T>=(1-1e-2);
[Lindex,Eindex] = ind2sub(size(T),min(find(Tequalsone')));
Earray = linspace(ep,2*eV,100);
Evalue = Earray(Eindex)/eV

Larray = linspace(0,1e-9,100);
Lvalue = Larray(Lindex)/(1e-9)

