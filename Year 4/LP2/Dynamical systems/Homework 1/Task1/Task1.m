%%
clear
figure(1)
clf
r = linspace(-10,10);
h = -r.^2/4;
hold on
plot(h,r)
xlabel('h', 'interpreter', 'latex')
ylabel('r', 'interpreter', 'latex')
xlim([-25 10])
legend('Bifurcation curve')
grid on 

txt = 'Two fixed points - one stable, one unstable';
text(-4, -7, txt)

txt = '\leftarrow One half-stable fixed point';
text(0,0, txt)

txt = 'No fixed points';
text(-20, 0, txt)

%%

clear

xArray = linspace(-10,10);
rArray = linspace(-15,15);
[X,R] = meshgrid(xArray,rArray);


H = X.^2 - X.*R;

figure(2)
clf
surf(H,R,X)

xlabel('h', 'interpreter', 'latex')
ylabel('r', 'interpreter', 'latex')
zlabel('x*', 'interpreter', 'latex')
xlim([-10 10])
ylim([-10 10])
%%
% clear
% f = @(x,h,r) h + x*(r-x);
% 
% hArray = linspace(-10,10);
% rArray = linspace(-10,10);
% [H,R] = meshgrid(hArray,rArray);
% xStarArray = zeros(size(H));
% 
% for i = 1:size(xStarArray, 1)
%     for j = 1:size(xStarArray, 2)
%         h = H(i,j);
%         r = R(i,j);
%         fun = @(x) f(x,h,r);
%         xStarArray(i,j) = fzero(fun, 0);
%     end
% end
%%
% h = 1;
% r = 0;
% fun = @(x) f(x,h,r);
% 
% 
% xStar = fzero(fun, 0)


% clear
% syms x(t)
% syms h
% syms r
% 
% f = h + x*(r-x);
% x0 = 0;
% 
% ode = diff(x,t) == f;
% cond = x(0) == x0;
% xSol(t, h, r) = dsolve(ode, cond);

