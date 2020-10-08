%%
%fall1
clf
gamma=[0.265,-0.995,0.882];
epsilon=0.1/(max(abs(gamma)));
om0=[1,epsilon,epsilon];
tspan=[0 10];
[t,om]=ode45(@problem1,tspan,om0);
hold on
axis equal
plot(t,om(:,1))
plot(t,om(:,2))
plot(t,om(:,3))
%%
%fall2
clf
gamma=[0.265,-0.995,0.882];
epsilon=0.1/(max(abs(gamma)));
om0=[epsilon,1,epsilon];
tspan=[0 10];
[t,om]=ode45(@problem1,tspan,om0);
hold on
plot(t,om(:,1))
plot(t,om(:,2))
plot(t,om(:,3))