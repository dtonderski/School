path0='D:\School\�r 2\LP3\Experimentell fysik\Del C\Data\DelcC\Two dimensions\27g\';

energycoeff=[];
b=[];
vel_rel=[];
rotenergy=[];
rotenergydividedbyvel1 = [];
theta=[];

for i=1:1:35
    clf
    path=strcat(path0,int2str(i),'.tsv');
    data = twodimensions(path);
    energycoeff = [energycoeff; data(1)];
    b = [b; data(2)];
    vel_rel = [vel_rel, data(3)];
    a=i;
    rotenergy = [rotenergy; data(4)];
    rotenergydividedbyvel1 = [rotenergydividedbyvel1; data(5)];
    theta = [theta; data(6)];
end
subplot(2,2,1)
plot(b,energycoeff, 'o')
subplot(2,2,2)
plot(vel_rel, energycoeff,'o')
subplot(2,2,3)
plot([1:a], energycoeff,'o')
subplot(2,2,4)
plot([1:a], rotenergy, 'o')

b_1 = find(b>0.018);
energycoeff_b_1 = [];
vel_rel_b_1 = [];
for i=1:1:length(b_1)
    energycoeff_b_1 = [energycoeff_b_1; energycoeff(b_1(i))];
    vel_rel_b_1 = [vel_rel_b_1; vel_rel(b_1(i))];
end
clf
subplot(2,2,2)
plot(vel_rel_b_1, energycoeff_b_1,'o');
title('b>0.018');


b_1 = find(b<0.018);
energycoeff_b_1 = [];
vel_rel_b_1 = [];
for i=1:1:length(b_1)
    energycoeff_b_1 = [energycoeff_b_1; energycoeff(b_1(i))];
    vel_rel_b_1 = [vel_rel_b_1; vel_rel(b_1(i))];
end

subplot(2,2,1)
plot(vel_rel_b_1, energycoeff_b_1,'o');
title('b<0.018');

vel_rel_1 = find(vel_rel<0.9);
energycoeff_vel_rel_1 = [];
b_vel_rel_1 = [];
for i=1:1:length(vel_rel_1)
    energycoeff_vel_rel_1 = [energycoeff_vel_rel_1; energycoeff(vel_rel_1(i))];
    b_vel_rel_1 = [b_vel_rel_1; b(vel_rel_1(i))];
end


subplot(2,2,4)
plot(b_vel_rel_1, energycoeff_vel_rel_1,'o');
title('vel_rel<0.9');

vel_rel_1 = find(vel_rel>0.9);
energycoeff_vel_rel_1 = [];
b_vel_rel_1 = [];
for i=1:1:length(vel_rel_1)
    energycoeff_vel_rel_1 = [energycoeff_vel_rel_1; energycoeff(vel_rel_1(i))];
    b_vel_rel_1 = [b_vel_rel_1; b(vel_rel_1(i))];
end

subplot(2,2,3)
plot(b_vel_rel_1, energycoeff_vel_rel_1,'o');
title('vel_rel>0.9');

clf
[theta,index]=sort(theta,'ascend');
rotenergydividedbyvel1=rotenergydividedbyvel1(index);

hold on
f=fit(theta, rotenergydividedbyvel1, 'A*cos(x) - B*(cos(x))^2', 'StartPoint', [11, 10]);



h = plot(f, theta, rotenergydividedbyvel1, 'ob');
set(h, 'MarkerSize', 8);
set(h, 'linewidth',2);
xlabel('\theta');
ylabel('E_{rot_{efter}} / v_{1_{innan}}');
coeffs=coeffvalues(f);
A = num2str(coeffs(1), 2);, B = num2str(coeffs(2), 2);
bestfit = strcat(A,'cos(\theta) - ', B, '⋅cos^2(\theta)');
legend('Mätdata', bestfit,'location','best');
ax = gca;
ax.FontSize = 15;


