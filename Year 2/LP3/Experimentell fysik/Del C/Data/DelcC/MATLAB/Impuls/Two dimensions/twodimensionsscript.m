clf, clc
path0='Z:\.win\My Documents\2dim\Qualisys\Data\27g\';

energycoeff=[];
b=[];
vel_rel=[];
rotenergy=[];


for i=1:1:35
    clf
    path=strcat(path0,int2str(i),'.tsv');
    data = twodimensions(path);
    energycoeff = [energycoeff; data(1)];
    b = [b; data(2)];
    vel_rel = [vel_rel, data(3)];
    a=i;
    rotenergy = [rotenergy; data(4)]
end
subplot(2,2,1)
plot(b,energycoeff, 'o')
subplot(2,2,2)
plot(vel_rel, energycoeff,'o')
subplot(2,2,3)
plot([1:a], energycoeff,'o')
subplot(2,2,4)
plot([1:a], rotenergy, 'o')