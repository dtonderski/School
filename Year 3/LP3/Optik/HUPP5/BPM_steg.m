function E2 = BPM_steg(E1, delta_z, N, a, lambda_noll, nmat, daempmat)
k_noll = 2*pi/lambda_noll;
n_PAS = sum(sum(nmat.*abs(E1)^2))/sum(sum(abs(E1)^2));
E2_pas = PAS(E1,delta_z,N,a,lambda_noll,n_PAS);
faskorrektion = k_noll*delta_z*(nmat-n_PAS);
if max(max(abs(faskorrektion)))>(2*pi*0.02) % max tillåten faskorrektion är 2% av 2p
    disp('Steglängd för stor')
    return
else
    E2=E2_pas.*exp(1i*faskorrektion).*daempmat;
end

