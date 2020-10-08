function r1=exit1(v0)
%Determines exit point and velocity of electron based on its initial velocity
tspan=[0,2];
y0=[1;0;v0]
options=odeset('events',@electronEvent);
[t,y]=ode45(@problem1,tspan,y0, options);
plot(y(:,1),y(:,2))
r1=y(size(y,1),1:2)';
end