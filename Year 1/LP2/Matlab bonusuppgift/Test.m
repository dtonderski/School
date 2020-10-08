X=3;
u0=[1/6;-1/2];
xspan=[0:0.0001:3];
[x,U]=ode45(@(x,u)diffekvation2(x,u),xspan,u0)
plot(x,U(:,1))
