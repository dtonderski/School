N_points = 512;
x_start = linspace(-5,5,N_points);
y_start = linspace(-5,5,N_points);
alpha = 0.15;
m1 = [-1,0,-0.5];
m2 = [ 1,0,-0.5];
tMax = 100;
fixedPoint1 = [-0.967642, 0];
fixedPoint2 = -fixedPoint1;
[X,Y] = meshgrid(x_start,y_start);
tol = 0.1;

pointData = zeros(size(X));

vx0 = 0;
vy0 = 0;

for i_x = 1:length(x_start)
    disp(i_x)
    for i_y = 1:length(y_start)
        x0 = X(i_x,i_y);
        y0 = Y(i_x, i_y);
        [~,data] = ode45(@(t,X) f(X,alpha,m1,m2),[0 tMax],[x0,y0,vx0,vy0]);
        pos_end = data(end,1:2);
        if norm(pos_end-fixedPoint1) < tol
            pointData(i_x, i_y) = 1;
        elseif norm(pos_end-fixedPoint2) < tol
            pointData(i_x, i_y) = 2;
        end
    end
end
%%
save('pointData', 'pointData')
figure(1)
contour(X,Y,pointData)
shading interp
xlabel('x')

[t,data] = ode45(@(t,X) f(X,alpha,m1,m2),[0 tMax],[x0,y0,vx0,vy0]);
figure(2)
plot(data(:,1), data(:,2))


function dXdt = f(X,alpha,m1,m2)
    x = X(1);
    y = X(2);
    vx = X(3);
    vy = X(4);
    pos = [x,y,0];
    vxdot = -alpha*vx - x + (m1(1) - x)/(norm(m1-pos))^5 + (m2(1) - x)/(norm(m2-pos))^5;
    vydot = -alpha*vy - y + (m1(2) - y)/(norm(m1-pos))^5 + (m2(2) - y)/(norm(m2-pos))^5;
    xdot = vx;
    ydot = vy;
    
    dXdt = [xdot;ydot;vxdot;vydot];
end