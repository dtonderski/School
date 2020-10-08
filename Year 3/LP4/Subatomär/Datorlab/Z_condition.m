function Z = Z_condition(X)
    syms r
    e = 1.60217646e-19; %C
    
    Z_integral = 0;
    r = 0;
    dr = 1e-17;
    
    while r < 1e-13
        Z_integral = Z_integral + r.^2.*rho_ch(r, X).*dr;
        r = r + dr;
    end
    
    Z = 4*pi/e * Z_integral;
end

