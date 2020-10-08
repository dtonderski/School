function matris = J_ret(alfa, phi)
    retarderingsmatris = [exp(j*phi) 0; 0 1];
    matris = J_proj(-alfa)*retarderingsmatris*J_proj(alfa);
end

