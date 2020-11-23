figure(2)
x = linspace(-1,1);
%r = -4*(2/9) + 9*(2/9)^2
r = 0;
xdot = r*x + 4*x.^3 - 9*x.^5;

plot(x, xdot)
title(sprintf('r = %.4f', r))
grid on
xlabel('x')
ylabel('xdot')
ylim([-1 1])

