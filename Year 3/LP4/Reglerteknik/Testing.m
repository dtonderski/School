s = linspace(0, 100);
w = [-100:0.1:100];
Kp = 0.2;

L = Kp * (1i * w - 8)./(1i*w + 2);
hold on
plot(real(L), imag(L))
