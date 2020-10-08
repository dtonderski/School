clc, clear all

data=load('k5_data_example.txt');
plot(data(:,1),data(:,2))
%%
E1 = 1.7743; %MeV
E2 = 1.9376; %MeV
E4 = 3.9299; %MeV

rangemin = 2260;
rangemax = 2310;
[peak1,fit1,fitrange]=fitpeak(rangemin,rangemax,data(:,1),data(:,2));
peak1

rangemin = 2475;
rangemax = 2525;
[peak2,fit2,fitrange]=fitpeak(rangemin,rangemax,data(:,1),data(:,2));
peak2

rangemin = 5036;
rangemax = 5086;
[peak4,fit4,fitrange]=fitpeak(rangemin,rangemax,data(:,1),data(:,2));
peak4
%%
ans = polyfit([peak1 peak2 peak4],[E1 E2 E4],1);
ch=data(:,1);
e=ans(1)*ch+ans(2);
figure;
semilogy(e,data(:,2))