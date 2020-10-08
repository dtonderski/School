%% Avdunstningshastighet salt
clf
v = [5.0258, 4.4768, 4.2432, 2.2516];
c = [0 0.05, 0.1, 0.3];
coefs = polyfit(c,v,1);
set(gca,'FontSize',24)
set(gca,'TickLabelInterpreter','latex')
hold on
plot(c,v,'o', 'MarkerSize', 9)
x = linspace(0, 0.35);
plot(x,polyval(coefs,x), 'LineWidth', 1.25)
xlim([0 0.4])
xlabel('Koncentration av NaCl [kg L${}^{-1}$]', 'interpreter', 'latex')
ylabel('Avdunstningshastighet [$10^{-8}$ kg s ${}^{-1}$]', 'interpreter', 'latex')
legend('\ Datapunkter', '$\ y = -9.18x + 5.03$', 'interpreter', 'latex');
%%
clf, hold on
plot(c,v,'o', 'MarkerSize', 9)
v=v/v(1);
xlabel('Koncentration av NaCl [kg L${}^{-1}$]', 'interpreter', 'latex')
ylabel('$E_a / E_0$ ', 'interpreter', 'latex')


x = linspace(0,0.5);
plot(x, (1.62./(x+1.62)).*(2.98./(x+2.98)));
ylim([0 1])
set(gca,'FontSize',24)
set(gca,'TickLabelInterpreter','latex')
legend('\ Datapunkter', '$\ \frac{2.98}{x + 2.98}\cdot\frac{1.62}{x+1.62}$', 'interpreter', 'latex');




