function mott = mott_crosssection(theta)
    thetarad = deg2rad(theta);
    Zt = 20;
    alpha = 0.0072973525693;
    hbar = 1.0545718e-34; %Js
    c = 299792458; %m/s
    MeV = 1.6021773e-13; %J
    E = 250 .* MeV; %J
    me = 9.109383632e-31; %kg
    %beta = sqrt((E^2 + 2*E*me*c^2)/(E^2 + 2*E*me*c^2 + me^2*c^4));
    beta = sqrt(1-me.^2*c.^4./E.^2);
    
    mott = Zt.^2 .* alpha.^2 .* hbar.^2 .* c.^2 ./ (4.*beta.^4.*E.^2.*(sin(thetarad./2)).^4)...
        .* (1 - beta.^2.*(sin(thetarad./2)).^2);    
end