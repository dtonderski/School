%% Massa
%VIII:
t=[0.47,0.56,0.63,0.7]
m=[5,7,9,11]
logt= log(t)
logm = log(m)
plot(logm,logt,'o')
grid on
ylim([1 3])
xlim([-1 0])
xlabel("log(m)")
ylabel("log(T)")
%% Tjocklek
r=[0.0045, 0.006]
t1=[0.595, 0.33]
t2=[0.66,0.37]
logr= log(r)
logt1=log(t1)
logt2=log(t2)
plot(logr, logt2)

