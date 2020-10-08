function r1=exit1(s0)
%Determines exit point of electron based on its initial velocity
tspan=[0,2];
y0=[1;0;s0(1);s0(2)]
options=odeset('events',@electronEvent)
[t,y]=ode45(@problem1,tspan,y0);
end