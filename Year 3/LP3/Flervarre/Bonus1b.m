close all,clc,clear
f = @(x,y) (sin(x+y)+3*(x-y/2).^2).*exp(-(x.^2+y.^2));
x = linspace(-5, 5);
y = linspace(-5, 5);
[X,Y] = meshgrid(x,y);
Z = f(X,Y);

figure(1)
hold on
contour(X,Y,Z)

figure(2)
hold on
surf(X,Y,Z)

options = optimset('Display','off');
fmin = @(x) f(x(1),x(2));

x0min = [0.3, -0.2];
for i = 1:size(x0min,1)
    [x, fval] = fminunc(fmin, x0min(i,:), options);
    disp(['Minimum', ' ', int2str(i), ':'])
    disp([x, fval])

    figure(1)
    hold on
    plot(x(1),x(2), 'xr')
    
    figure(2)
    plot3(x(1),x(2),fval, 'xr')
end

fmax = @(x) -f(x(1),x(2));

x0max = [1,0;-1,0];
for i = 1:size(x0max,1)
    [x, fval] = fminunc(fmax,x0max(i,:), options);
    disp(['Maximum', ' ', int2str(i), ':'])
    disp([x, -fval])

    figure(1)
    hold on
    plot(x(1),x(2), 'xb')
    
    figure(2)
    plot3(x(1),x(2),-fval, 'xb')
end