function Z = Z_condition(X)
    syms r
    e = 1.60217662e-19; %C
    Z = 4*pi/e * integral(@(r) r.^2.*rho_ch(r, X), 0, 1e-13);
end

