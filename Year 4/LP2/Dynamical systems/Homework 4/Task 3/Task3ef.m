%% Task 3ef
%% e
clear, clf
N = 2e6;
a = 1.4;
b = 0.3;
transient_length = 1e3;
x0 = 0; y0 = 0;
[x0, y0] = discard_initial_transient(x0, y0, transient_length, a, b);
x = zeros(1, N); y = zeros(1, N);
x(1) = x0; y(1) = y0;

Q = eye(2);
lambda = zeros(2,1);
for n = 1:N-1
    Jn = [-2*a*x(n), 1; b, 0];
    x(n+1) = y(n) + 1 - a*x(n)^2;
    y(n+1) = b*x(n);
    M = Jn;
    [Q, R] = qr(M*Q);
    lambda = lambda + log(abs(diag(R)));
end

lambda = lambda/(N-1);

%% f
ksi = [0, lambda(1), sum(lambda)];
plot(0:2, ksi)
Dl = 1 + ksi(2)/(ksi(2)-ksi(3));



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