%% Konstanter
%Glas
lambdaglas=0.9
cglas=0.84
rhoglas=2.5
kglas=lambdaglas/(cglas*rhoglas)
%% Uppgift 1
npunkter=20
x0=0.01
dx=x0/(npunkter-1)
x=linspace(0,x0,npunkter)
T1=zeros([npunkter 1])
T1(npunkter)=22
for(i=1:(length(x)))
    T1(i)=100*((i-1)*dx)*(x0-(i-1)*dx)/(x0^2)
end
T1(1)=T1(2)fifa
T1(npunkter)=T1(npunkter-1)
T2=T1;
T=T1;
dt=0.5*dx^2/kglas
difference=1
i=0
while(max(abs(difference))>0.05)
    for(m=2:npunkter-1)
        T2(m)=T1(m)+dt*kglas*(T1(m+1)-2*T1(m)+T1(m-1))/(dx^2)
    end
    T2(1)=T2(2)
    T2(npunkter)=T2(npunkter-1)
    T=[T T2]
    T2temp=T2
    T1temp=T1
    difference=T2-T1
    T1=T2
    i=i+1
end
t=linspace(0,dt*length(T),length(T))
contour(t,x,T,'Fill','on')



