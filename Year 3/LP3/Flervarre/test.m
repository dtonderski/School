close all, clf, clc,clear
f2 = @(x,y) x.*sin(x) + y.^2 - 2;
x = linspace(-20, 20);
y = linspace(-20, 20);
[X,Y] = meshgrid(x,y);
Z = f2(X,Y);

figure(1)
hold on
contour(X,Y,Z)

figure(2)
hold on
surf(X,Y,Z)