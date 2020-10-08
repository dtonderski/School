C=sqrt(9.807*0.062);
Cmax=sqrt(9.807*0.0654);
Cmin=sqrt(9.807*0.0586);
T1=[2.372, 2.35,2.326,2.346,2.395, 2.34, 2.34, 2.35];
T1max=T1+0.05;
T1min=T1-0.05;
L1=1.01;
L1max=L1+0.005;
L1min=L1-0.005;
T2=[3.05,3.03, 3.05, 3.05, 3.016, 3.06,3.02, 3.02];
L2=1.71;
T2max=T2+0.05;
T2min=T2-0.05;
L2max=L2+0.005;
L2min=L2-0.005;
K1=[C./sqrt(L1).*T1];
K2=[C./sqrt(L2).*T2];
Kf=[K1, K2];
K=mean(Kf)
K1max=[Cmax/sqrt(L1min).*T1max];
K2max=[Cmax./sqrt(L2min).*T2max];
K1min=[Cmin./sqrt(L1max).*T1min];
K2min=[Cmin./sqrt(L2max).*T2min];
Kfmax=[K1max, K2max];
Kfmin=[K1min,K2min];
Kmax=max(Kfmax)
Kmin=min(Kfmin)
Kf
Kfmin
Kfmax
