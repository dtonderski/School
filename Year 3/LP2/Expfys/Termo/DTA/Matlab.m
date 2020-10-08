clf
hold on
startend = [2705;  2477;	3000; 1785; 1387; 1000; 2459; 2470];
realstartpoint = [];
T=[];
indices = [];
for i=1:8
    data = xlsread("Meas"+i+".xlsx");
    startpoint = startend(i);
    
    peo = data(startpoint:end,1);
    peominusal2o3 = data(startpoint:end,2);
    [Min, minus70degreesind] = min(abs(peo+65));
    [Min, minus25degreesind] = min(abs(peo+40   ));
    realstartpoint = [realstartpoint, minus70degreesind];
    
    peo = peo(minus70degreesind:minus25degreesind);
    peominusal2o3 = peominusal2o3(minus70degreesind:minus25degreesind);

%     peo = data(2:end,1);
%     peominusal2o3 = data(2:end,2);
    hold on
    plot(peo, peominusal2o3);
    cost1 = [];
    for x=1:(size(peo))
        cost1 = [cost1; cost(x, peo, peominusal2o3)];
    end
    
    [Min, I] = min(cost1);
    indices = [indices, I];
    T = [T; peo(I)]
    
    subplot(8,2,2*i-1);
    plot(peo(1:I), peominusal2o3(1:I));
    hold on
    plot(peo(I:end), peominusal2o3(I:end));
    
    subplot(8,2, 2*i);
    plot(peo , -cost1);
    


end
