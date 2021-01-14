clf
mu = 1;
a = 2;
tmax = 100;
x0_array = [0.1, 0.1, -0.1, -0.1];
y0_array = [0.1, -0.1, 0.1, -0.1];

dydt = @(t, y) [y(2); -mu*(y(1)^2 + a*y(1)^4-1)*y(2)-y(1)];
hold on
for i = 1:length(x0_array)
    x0 = x0_array(i);
    y0 = y0_array(i);
    [t,y] = ode45(dydt, [1 tmax], [x0,y0]);

    plot(y(:,1), y(:,2))
end