%% Task 1
%% a
clear
figure(1)
clf

syms h r x

f = h +x*(r-x);
eq = f == 0;
S = solve(eq);

eq2 = S(1) == S(2);

h = solve(eq2, h); % -r^2/4

r = linspace(-10,10);
h = eval(h);

hold on
plot(h,r)
title('Plot of (h,r) plane', 'interpreter', 'latex')
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

%% b

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
zlabel('x', 'interpreter', 'latex')
title('Fixed points surface', 'interpreter', 'latex')
xlim([-10 10])
ylim([-10 10])