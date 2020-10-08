path0='Z:\.win\My Documents\extra\Data\Trä, 66 g, 6 cm (boll med cylindriskt hål med diametern 0.7 cm genom mitten (rullaxeln))\';
clf
ratio = [];
vel_z = [];
vel_x = [];

for i=1:1:13
    path = strcat(path0, int2str(i), '.tsv');
    data = extra(path);
    ratio = [ratio; data(3)];
    vel_z = [vel_z, data(2)];
    vel_x = [vel_x, data(1)];
end

subplot(2,2,4)
plot(vel_x, vel_z,'o');