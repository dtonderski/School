syms hbar a V m n E L;

k = sqrt(2*m*E)/hbar;
kappa = sqrt(2*m*(V-E))/hbar;

M1 = [1 1 ; k -k];   
M2 = [1 1 ; kappa -kappa];
M3 = [exp(1i*kappa*a) exp(-1i*kappa*a);kappa*exp(1i*kappa*a) -kappa*exp(-1i*kappa*a)];
M4 = [exp(1i*k0*a1) 0;k*exp(1i*k*a1) -k*exp(-1i*k*a)];

P = inv(M1)*M2*inv(M3)*M4;

Psi1 = [1; P(2,1)/P(1,1)];
Psi2 = (inv(M1)*M2)\Psi1;
psi=psi1*
