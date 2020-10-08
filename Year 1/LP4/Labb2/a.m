%%
%Löser problemet genom fmincon
m=3;
n=6;
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
options = optimset('MaxIter', 10000, 'Algorithm', 'interior-point');
x=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)
%%
%Ritar upp punkterna
% X=x(1,:);
% Y=x(2,:);
% Z=x(3,:);
% scatter3(X,Y,Z);
% rotate3d on;
% axis equal, hold on;
% [X1,X2,X3]=sphere;
% surf(X1,X2,X3,'FaceAlpha',0.3,'EdgeColor','none');
% quiver3(zeros(3,1),zeros(3,1),zeros(3,1),[1;0;0],[0;1;0],[0;0;1]);
%%
%Beräknar alpha
N=x*x.'
alpha(N)

%%
%Transformerar matrisen genom en Householder-spegling
x1=householder(x)
% clf
% X=x1(1,:);
% Y=x1(2,:);
% Z=x1(3,:);
% scatter3(X,Y,Z);
% rotate3d on;
% axis equal, hold on;
% [X1,X2,X3]=sphere;
% surf(X1,X2,X3,'FaceAlpha',0.3,'EdgeColor','none');
% quiver3(zeros(3,1),zeros(3,1),zeros(3,1),[1;0;0],[0;1;0],[0;0;1]);

%Roterar matrisen så att alla punkter ligger på koordinataxlarna
Rx=[1 0 0; 0 x1(2,2) x1(3,2); 0 -x1(3,2) x1(2,2)];
x2=Rx*x1
clf
X=x2(1,:);
Y=x2(2,:);
Z=x2(3,:);
scatter3(X,Y,Z);
rotate3d on;
axis equal, hold on;
[X1,X2,X3]=sphere;
surf(X1,X2,X3,'FaceAlpha',0.3,'EdgeColor','none');
quiver3(zeros(3,1),zeros(3,1),zeros(3,1),[1;0;0],[0;1;0],[0;0;1]);