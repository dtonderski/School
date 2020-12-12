clear, clf
n = 3;
dydt = @(t,y) (y(1)^2 + y(2)^2).^(abs(n)/2).*[cos(n*atan(y(2)/y(1))); sin(n*atan(y(2)/y(1)))];
r = 1;

hold on
X = [];
Y = [];
U = [];
V = [];
for theta = 0:0.1:2*pi

    x0 = r*cos(theta);
    y0 = r*sin(theta);
    [t,y] = ode45(dydt, [0 0.01], [x0;y0]);
    
    X = [X; x0];
    Y = [Y; y0];
    U = [U; y(2,1) - y(1,1)];
    V = [V; y(2,2) - y(1,2)];
end

quiver(X,Y,U,V)

xlim([-2 2])
ylim([-2 2])
