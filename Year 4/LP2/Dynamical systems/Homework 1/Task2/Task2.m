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
plot(x(x>breakpoint),r(x>breakpoint), 'black')
plot(x(x<breakpoint & x>-breakpoint),r(x<breakpoint & x>-breakpoint), 'black--')
plot(x(x<-breakpoint),r(x<-breakpoint), 'black')

grid on
xlabel('x')
ylabel('r')
title('Bifurcation diagram')
legend('x*')