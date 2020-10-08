function theo = theo_crossection(theta,X)
    mott = mott_crosssection(theta);
    c = 299792458; %m/s
    MeV = 1.6021773e-13; %J
    E = 250 .* MeV; %J
    me = 9.109383632e-31; %kg
    %beta = sqrt((E^2 + 2*E*me*c^2)/(E^2 + 2*E*me*c^2 + me^2*c^4));
    beta = sqrt(1-me.^2*c.^4./E.^2);
    v = beta.*c; %m/s
    p = me.*v./(sqrt(1-beta.^2)); %m*s;
    
    q = 2.*p.*sind(theta./2); % m*s
    F = form_factor(q, X);
    
    theo = mott * (abs(F))^2*1e31;
    
    
    

end

