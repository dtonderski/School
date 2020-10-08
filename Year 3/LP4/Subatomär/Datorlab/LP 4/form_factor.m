function F = form_factor(q, X)
    syms r
    Zt = 20;
    hbar = 1.0545718e-34; %Js
    e = 1.60217662e-19; %C
    
    F = 4.*pi.*hbar./(Zt.*e.*q).* integral(@(r) r.* rho_ch(r,X).*sin(q.*r./hbar), 0, 1e-13);
end

