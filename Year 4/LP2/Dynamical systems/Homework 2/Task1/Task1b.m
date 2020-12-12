clear, clf
a = 1;

dydt = @(t,y) [a*y(1); 0];

r = 0.01;

hold on
X = [];
Y = [];
U = [];
V = [];
for theta = 0:0.1:2*pi

    x0 = r*cos(theta);
    y0 = r*sin(theta);
    [t,y] = ode45(dydt, [0 1], [r, theta]);
    
    X = [X; x0];
    Y = [Y; y0];
    
    [u,v] = pol2cart(theta, y(2,1) - y(1,1));
    U = [U; u];
    V = [V; v];
end

quiver(X,Y,U,V)

