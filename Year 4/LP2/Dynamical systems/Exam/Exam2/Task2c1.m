clf
mu = 0.01;
hold on
tmax = 1000;
dt = 1e-2;
x0 = 0.5;
y0 = 0.5;

for a = [0, 2, 5]

    dydt = @(t, y) [y(2); -mu*(y(1)^2 + a*y(1)^4-1)*y(2)-y(1)];
    [~,y] = ode45(dydt, [0 tmax], [x0,y0]);
    r = mean(sqrt(sum(y(end-100:end,:).^2,2)));

    x0 = r; %radius
    y0 = 0;
    [t,y] = ode45(dydt, [0 tmax], [x0,y0]);

    [pks, tlocs] = findpeaks(y(:,1),t);
    T = mean(tlocs(2:end)-tlocs(1:end-1));
    [t,y] = ode45(dydt, [0 T], [x0,y0]);
    plot(y(:,1), y(:,2), 'red')
end
