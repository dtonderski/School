load('task3c.mat')
figure(1)
clf
hold on
for i = 1:3
    semilogx(timeData, lambdaData(:,i))
end
legend('$\lambda_1$', '$\lambda_2$', '$\lambda_3$', 'interpreter', 'latex')
xlabel('t')
ylabel('\lambda', 'interpreter', 'latex')