function velocities = extra(path)

data = load(path);

%subplot(2,2,1)
pos_x = data(:,3);
pos_z = data(:,5);
time = data(:,2);
%plot(time, pos_x, time, pos_z)

subplot(2,2,2)
vel_x = velocity(pos_x, time);
vel_z = velocity(pos_z, time);
time_vel = time(1:length(vel_z));
plot(time_vel, vel_x, time_vel, vel_z)

subplot(2,2,3)
vel_x_smooth = smoothdata(vel_x, 'gaussian', 40);
vel_z_smooth = smoothdata(vel_z, 'gaussian', 40);
plot(time_vel, vel_x_smooth, time_vel, vel_z_smooth)

vel_x_final = max(vel_x_smooth);
vel_z_final = max(vel_z);
ratio_final = vel_z_final/vel_x_final;

velocities=[vel_x_final, vel_z_final, ratio_final];



