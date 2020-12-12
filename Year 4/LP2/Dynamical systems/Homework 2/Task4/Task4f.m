mu = [0.065, 0.064, 0.063, 0.062, 0.061, 0.060, 0.059];
T = [12.4699, 11.4586, 10.8724, 10.457, 10.1344, 9.85957, 9.63421];

mulinspace = linspace(0.065, 0.059);

muc = 0.066;
A = 2.4053;
a = 0.7258;
eigen = @(mu) (2*mu-1+sqrt(5+9*mu.^2+4*mu.^3+mu.^4))./(2+mu);
eigen(0.065)

C = mean(-T ./ (log(A*(abs(mu-muc).^a))./eigen(mu)));

estimatedT = -C*(log(A*(abs(mulinspace-muc).^a))./eigen(mulinspace));

% for i = 1:length(mu)
%     fprintf('Mu is %.4f, T is %.3f, estimated T is %.3f.\n', mu(i), T(i),  estimatedT(i))
% end

clf
hold on
p1 = plot(muc-mu,T, 'xblack');
plot(muc-mu,T, 'black')
p2 = plot(muc-mulinspace,estimatedT);
xlabel('$\mu_c - \mu$', 'interpreter', 'latex')
ylabel('$T$', 'interpreter', 'latex')
title('Plot of numerically obtained period and estimated period', 'interpreter', 'latex')
legend([p1, p2], 'Numerically obtained period', 'Estimated period')

