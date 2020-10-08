f=@(x,y)x.^2./a^2+y.^2./b^2
a=1
b=1
x=linspace(-1,1); y=linspace(-1,1)
[X,Y]=meshgrid(x,y)
Z=f(X,Y);
surf(X,Y,Z)
grid on
xlabel('x'), ylabel('y'), zlabel('z')
rotate3d on
%%
f=@(x,y)x.^2./a^2-y.^2./b^2
a=1
b=1
x=linspace(-1,1); y=linspace(-1,1)
[X,Y]=meshgrid(x,y)
Z=f(X,Y);
surf(X,Y,Z)
grid on
xlabel('x'), ylabel('y'), zlabel('z')
rotate3d on
%%
x=[-0.1:0.001:0.1]; y=[-0.1:0.001:0.1]
f=@(x,y)x.*y./(x.^2+y.^2)
[X,Y]=meshgrid(x,y)
Z=f(X,Y);
surf(X,Y,Z)
grid on
xlabel('x'), ylabel('y'), zlabel('z')
rotate3d on