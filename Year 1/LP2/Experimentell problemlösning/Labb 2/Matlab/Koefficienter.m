%%best�m e (d/D)
%L=1.71m, K=1.81, alfa=0.062 ( = sin alfa)
T=[3.218, 3.054, 3.196, 3.202, 3.166, 3.334, 3.1, 3.23]
a=sqrt(9.81*sin(0.062)/1.71)/1.8167
D=[0.025, 0.025, 0.02, 0.026, 0.035, 0.058, 0.056, 0.068]
d=[0.02, 0.015, 0.015, 0.02, 0.025, 0.055, 0.037, 0.058]
Y=T.*a-1
y=log(Y)
X=d./D
x=log(X)
plot(x,y,'o')
%%best�m K
L1=1.01
L2=1.71
m=sqrt(9.80665*sin(0.062))
T1=[2.372, 2.35, 2.326,2.326,2.346,2.395, 2.34, 2.34, 2.35]
T2=[3.05,3.03, 3.05, 3.05, 3.016, 3.06,3.02, 3.02]
K1=[m./sqrt(L1).*T1]
K2=[m./sqrt(L2).*T2]
Kf=[K1, K2]
K=mean(Kf)