data = xlsread("Meas3.xlsx");
peo = data(2:end,1);
peominusal2o3 = data(2:end,2);


plot(peo, peominusal2o3);
cost1 = [];
%%
for x=[2:size(data,1)]
    cost1 = [cost1; cost(x, data)];
end
[Min, I] = min(cost1)
%%
plot(peo(start:I), peominusal2o3(start:I));
hold on
plot(peo(I:end), peominusal2o3(I:end));


%plot(peo(I+start+1), peominusal2o3(I+start+1), 'o')

