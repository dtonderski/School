function matris = J_pol( alfa )
    polarisationsmatris=[1 0; 0 0];
    matris = J_proj(-alfa) * polarisationsmatris * J_proj(alfa);
end

