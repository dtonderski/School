%%
clf
x=[-1:0.15:3];
y=[-1:0.15:3];
[X,Y]=meshgrid(x,y)
u=cos(X-Y);
v=sin(X.*Y);
quiver(x,y,u,v)
hold on
axis([0 3 -0.1 3])
x0=[0:0.25:3]
y0=[0:0.25:3]
for i=1:length(x0)
    for k=1:length(y0)
        u0=[x0(i);y0(k)];
        tspan=[0:0.01:3];
        [t,U]=ode45(@(z,u)diffekvation2(z,u),tspan,u0)
        plot(U(:,1),U(:,2))
    end
end

