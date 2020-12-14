load('task3a.mat')
figure(1)
hold on
for i = 1:3
    semilogx(timeVector, lambdaData(:,i))
end
legend('$\lambda_1$', '$\lambda_2$', '$\lambda_3$', 'interpreter', 'latex')
xlabel('t')
ylabel('