close all, clf, clc
f1 = @(x,y) x.*y + exp(x) + x - 3;
f2 = @(x,y) x.*sin(x) + y.^2 - 2;
interval = [-30 30 -30 30];
fimplicit(f1, interval)
hold on
fimplicit(f2, interval)
fundiff = @(x) [f1(x(1),x(2)); f2(x(1),x(2))];
x0 = [[0.6, 1.2]; [1.1, -1]; [-3.5, -1.9]; [-6, -1.6]];
solution = [];
options = optimset('Display','off');
for j = [1:4]
    solution = [solution; fsolve(fundiff, x0(j,:),options)];
    plot(solution(j,1), solution(j,2), 'o');
end
disp(solution)