function mott = mott_crosssection(theta)
    thetarad = deg2rad(theta);
    Zt = 20;
    alpha = 7.297352533e-3;
    hbar = 1.05457160e-34; %Js
    c = 299792458; %m/s
    MeV = 1.6021765e-13; %J
    E = 250 .* MeV; %J
    me = 9.1093819e-31; %kg
    beta = sqrt(1-me.^2*c.^4./E.^2);
    
    mott = Zt.^2 .* alpha.^2 .* hbar.^2 .* c.^2 ./ (4.*beta.^4.*E.^2.*(sin(thetarad./2)).^4)...
        .* (1 - beta.^2.*(sin(thetarad./2)).^2);    
end