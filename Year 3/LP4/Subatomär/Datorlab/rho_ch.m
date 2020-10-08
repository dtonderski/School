function rho = rho_ch(r, X)
    rho_ch_0 = X(1);
    a = X(2);
    b = X(3);
    rho = rho_ch_0./(1+exp((r-a)./b));
end

