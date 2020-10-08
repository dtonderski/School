%%
clf
%Uppskrivning av systemet
%inom cirkeln
A=[0 0 1 0; 0 0 0 1; 0 0 0 1; 0 0 -1 0];
B=[0; 0; 1; 0];
%utanför cirkeln
A1=[0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0];
hold on
theta=linspace(0,2*pi);
plot(cos(theta),sin(theta));
axis equal
grid on
%%
%Lösning av problem 1 med ode45
tspan=[0 2];
y0=[1; 0; -2; 0];
options=odeset('events',@electronEvent);
[t,y,te,ye,ie]=ode45(@problem1, tspan, y0, options);
plot(y(:,1),y(:,2));
te
ye
%%
%Lösning av problem 1 med Euler framåt
h=0.1
htot=0
y=y0
y1=[y]
while htot<2
    y=y+h.*problem1(0,y)
    y1=[y1,y]
    htot=htot+h
end
plot(y1(1,:),y1(2,:))
%%
%Lösning av problem 1 med Euler bakåt
h=0.1
htot=0
y=y0
y1=[y]
while htot<2
    %Om den är utanför cirkeln
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   s
    if y(1)^2+y(2)^2>1
        y=(eye(size(A1))-h.*A1)\y
    else
        y=(eye(size(A))-h.*A)\(y+h.*B)
    end
    y1=[y1,y]
    htot=htot+h
end
plot(y1(1,:),y1(2,:))
%%
%Lösning av problem 1 med trapetsmetoden
h=0.1
htot=0
y=y0
y1=[y]
while htot<2
    %Om den är utanför cirkeln
    if y(1)^2+y(2)^2>1
        y=(eye(size(A1))-h/2.*A1)\((eye(size(A1))+h/2.*A1)*y)
    else
        y=(eye(size(A))-h/2.*A)\((eye(size(A1))+h/2.*A)*y+h.*B)
    end
    y1=[y1,y]
    htot=htot+h
end
plot(y1(1,:),y1(2,:))
%%
%
clf
difference([-1;0])
x=fsolve(@difference,[-1;0])
hold on
theta=linspace(0,2*pi);
plot(cos(theta),sin(theta));
grid on
axis equal
%%
%stabilitet
I=eye(size(A))
eig(I+h.*A)
A2=inv(I-A.*h)
eig(A2)
A3=inv(I-h/2.*A)*(I+h/2.*A)
eig(A3)
