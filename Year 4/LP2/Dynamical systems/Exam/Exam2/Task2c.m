clf
mu = 0.01;
hold on
tmax = 1e3;
x0 = 0.5;
y0 = 0.5;
a_array = linspace(0,5);
r_array = zeros(1,length(a_array));
T_array = zeros(1,length(a_array));

for i = 1:length(a_array)
    a = a_array(i);
    dydt = @(t, y) [y(2); -mu*(y(1)^2 + a*y(1)^4-1)*y(2)-y(1)];
    [~,y] = ode45(dydt, [0 tmax], [x0,y0]);
    r = mean(sqrt(sum(y(end-100:end,:).^2,2)));

    x0 = r; %radius
    y0 = 0;
    [t,y] = ode45(dydt, [0 tmax], [x0,y0]);

    [pks, tlocs] = findpeaks(y(:,1),t);
    T = mean(tlocs(floor(end/2)+1:end)-tlocs(floor(end/2):end-1));
    r_array(i) = r;
    T_array(i) = T;
end
figure(1)
plot(a_array, r_array);
plot(a_array, sqrt((sqrt(1+8*a_array)-1)./a_array));
figure(2)
plot(a_array, T_array);
plot(a_array, 2*pi*ones(size(a_array)));


