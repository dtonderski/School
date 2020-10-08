a=0.9;, T=15;
u0=[0.2;0];
tspan=[0:0.001:T];
[t,U]=ode45(@(t,u)diffekvation1(t,u,a),tspan,u0)
plot(t,U(:,1))