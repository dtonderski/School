clc, clear all, close all
data=load('207bi_46.5h.txt');
plot(data(:,1),data(:,2), 'LineWidth', 2)
%%
E2 = 482; %keV
E4 = 976; %keV
E5 = 1048; %keV
hold on

rangemin = 2725;
rangemax = 2775;
[peak2,fit2,fitrange]=fitpeak(rangemin,rangemax,data(:,1),data(:,2));
%plot(data(rangemin+1:rangemax-1,1), fit2,'r', 'LineWidth', 2)
xline(peak2, '--r', 'LineWidth', 2);
disp(peak2)

rangemin = 5559;
rangemax = 5609;
[peak4,fit4,fitrange]=fitpeak(rangemin,rangemax,data(:,1),data(:,2));
%plot(data(rangemin+1:rangemax-1,1), fit4,'r', 'LineWidth', 2)
xline(peak4, '--r', 'LineWidth', 2);
disp(peak4)

rangemin = 5975;
rangemax = 6025;
[peak5,fit5,fitrange]=fitpeak(rangemin,rangemax,data(:,1),data(:,2));
%plot(data(rangemin+1:rangemax-1,1), fit5, 'r', 'LineWidth', 2)
xline(peak5, '--r', 'LineWidth', 2);
disp(peak5)
hold off
set(gca, 'FontSize', 22)
xlim([0,8192])
ylabel('Antal detektioner', 'Interpreter', 'latex')
xlabel('Kanalnummer', 'Interpreter', 'latex')
legend('Detektordata','Hittade toppar')
%%
fit = polyfit([peak2 peak4 peak5],[E2 E4 E5],1);
ch=data(:,1);
e=fit(1)*ch+fit(2);
figure(2)
plot(e,data(:,2), 'LineWidth', 2)
ylabel('Antal detektioner', 'Interpreter', 'latex')
xlabel('Energi [keV]', 'Interpreter', 'latex')
set(gca, 'FontSize', 22);
xlim([0,e(end)]);

%%
clf
dataCS = load('137cs_117h.txt');
dataBG = load('background_97h.txt');
countsCSnormalised = dataCS(:,2) - dataBG(:,2)*117/97;
dataCSnormalised = [dataCS(:,1), countsCSnormalised];

figure(1)
ch=dataCSnormalised(:,1);
e=fit(1)*ch+fit(2);
semilogy(e, dataCSnormalised(:,2), 'LineWidth', 2)
set(gca, 'FontSize', 22)
xline(55, 'r--', 'LineWidth', 2);
xline(680, 'k--', 'LineWidth', 2);

xline(490, 'r--', 'LineWidth', 2);
xline(1000, 'k--', 'LineWidth', 2);

ylabel('Antal detektioner', 'Interpreter', 'latex')
xlabel('Energi [keV]', 'Interpreter', 'latex')
legend('Detektordata', 'Låga energibranchen', 'Höga energibranchen')
set(gca,'YMinorTick','off')
%%
figure(3)
clf
[kuriedata] = kurieplot(e, dataCSnormalised, 56);
close
plot(e, kuriedata, 'LineWidth', 2)
ylabel('$\sqrt{\frac{N(T_e)}{\sqrt{T_e} F(Z,T_e)}}$', 'interpreter', 'latex')
xlabel('Energi [keV]', 'Interpreter', 'latex')
set(gca, 'FontSize', 22)
xlim([0,e(end)])

range1 = 55:490;
range2 = 680:1000;
[slope1, offset1] = kuriefit(e, kuriedata, range1);
[slope2, offset2] = kuriefit(e,kuriedata,range2);
Q1 = -offset1/slope1;
figure(4)
close
figure(5)
close
figure(3)
hold on
plot(range1, offset1+range1*slope1, 'r--', 'LineWidth', 2)
plot(range2, offset2+range2*slope2, 'r--', 'LineWidth', 2)
Q2 = -offset2/slope2;
legend('Kurie-plot', 'Linjäranpassningar')

thalf = 30; %years
lambda = log(2)/thalf; %1/years
lambda1 = 0.9*lambda; %1/years
lambda2 = 0.1*lambda; %1/years
thalf1 = log(2)/lambda1; %years
thalf2 = log(2)/lambda2; %years
thalf1seconds = thalf1 * 31556952; %seconds
thalf2seconds = thalf2 * 31556952; %seconds

log10thalf1 = log10(thalf1seconds);
log10thalf2 = log10(thalf2seconds);

log10fZQ1 = log10f(56, Q1);
log10fZQ2 = log10f(56, Q2);

log10fthalf1 = log10fZQ1 + log10thalf1 %9.0220 First-forbidden unique

log10fthalf2 = log10fZQ2 + log10thalf2 %9.9762 Second-forbidden