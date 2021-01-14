%% Task 3a
clear
N = 2e6;
a = 1.4;
b = 0.3;
transient_length = 1e3;

clf
hold on
x0 = 0; y0 = 0;
[x,y] = get_henon_data(x0, y0, transient_length, a, b, N);
plot(x,y, '.blue')

x0 = 0.5; y0 = 0.5;
[x,y] = get_henon_data(x0, y0, transient_length, a, b, N);
plot(x,y, '.blue')


x0 = 1; y0 = 1;
[x,y] = get_henon_data(x0, y0, transient_length, a, b, N);
plot(x,y, '.blue')

xlabel('x')
ylabel('y')
title(sprintf("%.0e iterations of H\\'enon map with $a = 1.4, b = 0.3$ and starting points (0,0), (0.5,0.5), (1,1), discarding the initial %.1e points.", N, transient_length), 'interpreter', 'latex')

function [x,y] = get_henon_data(x0, y0, transient_length, a, b, N)
    [x0, y0] = discard_initial_transient(x0, y0, transient_length, a, b);

    x = zeros(1, N);
    y = zeros(1, N);

    x(1) = x0;
    y(1) = y0;

    for n = 1:N-1
        x(n+1) = y(n) + 1 - a*x(n)^2;
        y(n+1) = b*x(n);
    end
end

function [x0, y0] = discard_initial_transient(x0, y0, transient_length, a, b)
    x = zeros(1, transient_length);
    y = zeros(1, transient_length);
    
    x(1) = x0;
    y(1) = y0;

    for n = 1:transient_length-1
        x(n+1) = y(n) + 1 - a*x(n)^2;
        y(n+1) = b*x(n);
    end

    x0 = x(transient_length);
    y0 = y(transient_length);
end