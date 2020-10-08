clf
m=3;
n=3;
M=ones(m,n);
fun=@distance;
nonlcon=@unitsphere;
A=[];
b=[];
Aeq = [];
beq = [];
lb = [];
ub = [];
x0=M;
options = optimset('MaxIter', 1000, 'Algorithm', 'interior-point');
x=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);

x
X=x(1,:)
Y=x(2,:)
Z=x(3,:)
scatter3(X,Y,Z)
rotate3d on;
axis equal, hold on;
[X1,X2,X3]=sphere;
surf(X1,X2,X3,'FaceAlpha',0.3,'EdgeColor','none')
x
distance(x)
