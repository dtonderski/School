%% TASK 2
%%
syms r x

f =  r*x + 4*x.^3 - 9*x.^5;
eqn = f == 0;
S = solve(eqn, r);

x = linspace(-1,1);
r = eval(S);

S1 = solve(diff(S));

breakpoint = S1(3);
figure(1)
clf

hold on
plot(r(x>breakpoint), x(x>breakpoint), 'black')
plot(r(x<breakpoint & x>-breakpoint), x(x<breakpoint & x>-breakpoint), 'black--')
plot(r(x<-breakpoint), x(x<-breakpoint), 'black')
xlim([-1 1  ])
ylim([-1 1])
line([-1 0], [0 0], 'Color','black')
line([ 0 5], [0 0], 'LineStyle', '--', 'Color','black')
p1 = plot(0,0, 'rx', 'MarkerSize', 15);
x = double(S1(2:3));
r = eval(S);
p2 = plot(r,x, 'bluex', 'MarkerSize', 15);

legend([p1 p2], 'Subcritical pitchfork bifurcation', 'Saddle-node bifurcation', 'Location', 'northwest')

grid on
xlabel('r')
ylabel('x')
title('Bifurcation diagram')
