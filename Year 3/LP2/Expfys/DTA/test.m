for i=1:8
    subplot(8,2, 2*i-1);
    data = xlsread("Meas"+i+".xlsx");
    peo = data(1:end,1);
    peominusal2o3 = data(1:end,2);
    plot(peo, peominusal2o3);

    
    subplot(8,2,2*i);
    I = indices(i) + realstartpoint(i) + startend(i);
    plot(peo(1:I), peominusal2o3(1:I));
    hold on
    plot(peo(I:end), peominusal2o3(I:end));
end