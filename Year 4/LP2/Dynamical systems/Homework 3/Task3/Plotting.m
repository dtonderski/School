clear
load('task3c.mat')
figure(1)
clf
for i = 1:3
    semilogx(timeData, lambdaData(:,i))
    hold on
end
legend('$\lambda_1$', '$\lambda_2$', '$\lambda_3$', 'interpreter', 'latex')
xlabel('t')
ylabel('$\lambda$', 'interpreter', 'latex')
title(sprintf('Evolution of $\\lambda(t)$ for $t \\in [20;%d]$ with $dt = %.0e, \\sigma = %d, r = %d, b \\approx %.2f$',...
    round(timeData(end)), dt ,sigma, r, b),...
    'interpreter', 'latex')