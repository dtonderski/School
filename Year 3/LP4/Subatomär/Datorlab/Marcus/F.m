function [sum] = F(theta,X)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
Zp = 1;
Zt = 20;
eps_0 = 8.8541878128e-12; % F/m
e = 1.602176634e-19; % C
hbar = 6.62607015e-34/(2*pi); % Js
c = 299792458;
alpha = 1/(4*pi*eps_0)*e^2/(hbar*c);
E_tot = 249.5e6*1.60218e-19; %J
m_rest = 8.1871057769e-14; % J
m_e = 9.1093837015e-31; %Kg
gamma = E_tot/m_rest;
p = sqrt(E_tot^2-m_e^2*c^4)/c;
betaFactor = sqrt(1-1/gamma^2);


Pch = @(r,X) X(1)./( 1 + exp( (r-X(2))./X(3) ));
dr = 0.001e-15;
sum = 0;
r = 0;
q = 2.*p.*sin(theta./2);

while true
    dSum = r.*Pch(r,X).*sin(q.*r./hbar).*dr;
    
    sum = sum + dSum;
    
    r = r + dr;
    
    if r > 100e-15
       break; 
    end
    
end
%f = @(r) r.*Pch(r,X).*sin(q.*r./hbar);

%sum = quadgk(f,0,inf,'MaxIntervalCount',10000,'RelTol',1e-7);

sum = sum.*4.*pi.*hbar./(Zt.*e.*q);
end

