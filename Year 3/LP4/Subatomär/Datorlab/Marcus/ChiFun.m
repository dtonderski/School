function [chi2] = ChiFun(X,data)

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

dSig_dOhm_Mott = @(theta) (Zp.*Zt.*alpha.*hbar.*c).^2./(4.*betaFactor.^4.*E_tot.^2.*sin(theta./2).^4).*(1-betaFactor.^2.*sin(theta./2).^2);

chi2 = 0;
for i=1:length(data(:,1))
   
    theta = data(i,1).*pi./(180);
    
    chi2 = chi2+ ( ( dSig_dOhm_Mott(theta).*abs(F(theta,X)).^2 - data(i,2) )./data(i,3) ).^2 + ( (Zt - Zint(X))./(1e-6) ).^2;
    
end
end

