clear,clc,clf
slope = [];
filenames = ["Avjoniserat vatten.xlsm", "50gsalt.xlsx", "100gsalt.xlsx", "300gsalt.xlsx", "Natriumacetat100g.xlsx", "NatriumacetatUtanvatten100g.xlsx", "Natriumsulfat10vatten100g.xlsx", "Natriumtetraborat10vatten100g"];

    
for i = [1:size(filenames,2)]
    data = xlsread(filenames(i));
    weight = data(:,1);
    time = [1:size(weight)]'.*30; %%time in seconds, each measurement is around 0.50 s
    p = polyfit(time, weight, 1);
    slope = [slope; filenames(i), p(1)];
end
slope
hold on

% data = xlsread("300gsalt.xlsx");
% weight = data(:,1);
% time = [1:size(weight)]'.*30;
% plot(time, weight);
% hold on
% 
% data = xlsread("100gsalt.xlsx");
% weight = data(:,1);
% time = [1:size(weight)]'.*30;
% plot(time, weight);
% hold on
