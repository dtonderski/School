clear, clf
dydt = @(t,y) [y(2) - y(1); y(1)^2];
r = 2;

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

xlim([-5 5])
ylim([-5 5])
