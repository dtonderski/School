function F = form_factor(q, X)
    syms r
    Zt = 20;
    hbar = 1.05457160e-34; %Js
    e = 1.60217646e-19; %C
    
    F_integral = 0;
    r = 0;
    dr = 1e-17;
    
    while r < 1e-13
        F_integral = F_integral + r.* rho_ch(r,X).*sin(q.*r./hbar).*dr;
        r = r + dr;
    end
    
    F = 4.*pi.*hbar./(Zt.*e.*q).* F_integral;
    
end

