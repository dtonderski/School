a=0.9;, T=15;
u0=[0.2;0];
tspan=linspace(0,T)
[t,U]=ode45(@(t,u)diff(t,u),tspan,u0);
plot(t,U)