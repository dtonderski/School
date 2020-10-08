%% data
path='/chalmers/users/davton/Årskurs 2/LP4/Expfys del C/Data/Two dimensions/27g/9.tsv';
data = load(path);
pos_x_1_centrum = data(:,3);
pos_y_1_centrum = data(:,4);
pos_x_1_rand    = data(:,6);
pos_y_1_rand    = data(:,7);

pos_x_2_centrum = data(:,9);
pos_y_2_centrum = data(:,10);
pos_x_2_rand    = data(:,12);
pos_y_2_rand    = data(:,13);

time = data(:,2);

%% vel
vel_x_1_centrum = velocity(pos_x_1_centrum, time);
vel_y_1_centrum = velocity(pos_y_1_centrum, time);
vel_x_1_rand    = velocity(pos_x_1_rand, time);
vel_y_1_centrum = velocity(pos_y_1_rand, time);

vel_x_2_centrum = velocity(pos_x_2_centrum, time);
vel_y_2_centrum = velocity(pos_y_2_centrum, time);
vel_x_2_rand    = velocity(pos_x_2_rand, time);
vel_y_2_rand    = velocity(pos_y_2_rand, time);

time_vel = time(1:(length(time)-1));
subplot(2,2,4)
plot(time_vel, vel_x_2_centrum)

%% collision
vel_x_1_centrum_smooth  = smoothdata(vel_x_1_centrum, 'gaussian', 40);
vel_x_1_rand_smooth     = smoothdata(vel_x_1_rand, 'gaussian', 40);
vel_x_2_centrum_smooth  = smoothdata(vel_x_2_centrum, 'gaussian', 40);
vel_x_2_rand_smooth     = smoothdata(vel_x_2_rand, 'gaussian', 40);
plot(time_vel, vel_x_2_centrum_smooth);
hold on
TF = ischange(vel_x_2_centrum_smooth,'linear','MaxNumChanges',4);

collisions              = find(TF==1);
collision_1_start       = collisions(1);
[leet, collision_1_end] = max(vel_x_2_centrum_smooth);
collision_2_start       = collisions(3);
collision_2_end         = collisions(4);
TF(collisions(2))       = 0;
TF(collision_1_end)     = 1;
plot(time_vel, TF*500);

%% b

r_21_x = abs(pos_x_1_centrum-pos_x_2_centrum);
r_21_y = abs(pos_y_1_centrum - pos_y_2_centrum);
r_21   = sqrt((r_21_x).^2 + (r_21_y).^2);

r_21_min   = min(r_21);
collision_middle = find(r_21==r_21_min);
r_21_x_min = r_21_x(collision_middle);
r_21_y_min = r_21_y(collision_middle);

vel_11_x = mean(vel_x_1_centrum(floor(collision_1_start*95/100):collision_1_start));
vel_11_y = mean(vel_y_1_centrum(floor(collision_1_start*95/100):collision_1_start));

vel_11 = sqrt(vel_11_x^2 + vel_11_y^2);
costheta = (vel_11_x*r_21_x_min + vel_11_y*r_21_y_min)/(r_21_min*vel_11);

b=r_21_min*sqrt(1-costheta^2)/1000;
vel_rel = vel_11/1000;

%% v_22 and v_12

vel_12_x = mean(vel_x_1_centrum(collision_1_end:(collision_1_end + floor((collision_2_start-collision_1_end)*5/100))));
vel_12_y = mean(vel_y_1_centrum(collision_1_end:(collision_1_end + floor((collision_2_start-collision_1_end)*5/100))));

vel_12 = sqrt(vel_12_x^2 + vel_12_y^2);

vel_22_x = mean(vel_x_2_centrum(collision_1_end:(collision_1_end + floor((collision_2_start-collision_1_end)*5/100))));
vel_22_y = mean(vel_y_2_centrum(collision_1_end:(collision_1_end + floor((collision_2_start-collision_1_end)*5/100))));

vel_22 = sqrt(vel_22_x^2 + vel_22_y^2);

%% rotation
r_y_1 = pos_y_1_rand - pos_y_1_centrum;
r_y_2 = pos_y_2_rand - pos_y_2_centrum;

omega_1 = (vel_x_1_centrum_smooth - vel_x_1_rand_smooth)./r_y_1(1:length(vel_x_1_centrum));
omega_2 = (vel_x_2_centrum_smooth - vel_x_2_rand_smooth)./r_y_2(1:length(vel_x_2_centrum));

omega_11 = mean(omega_1(floor(collision_1_start*95/100):collision_1_start));
omega_12 = mean(omega_1(collision_1_end:(collision_1_end + floor((collision_2_start-collision_1_end)*5/100))));
omega_22 = mean(omega_2(collision_1_end:(collision_1_end + floor((collision_2_start-collision_1_end)*5/100)))); 
subplot(2,2,1)
plot(time_vel, omega_1)
subplot(2,2,2)
plot(time_vel, omega_2)

k=1/2

%% energy coefficient
transenergycoeff = (vel_22^2 + vel_12^2)/(vel_11^2);
rotenergy = k*(r_21_min/2)^2*(omega_12^2+omega_22^2-omega_11^2)/(k*(r_21_min/2)^2*(omega_12^2+omega_22^2)+vel_22^2+vel_12^2)
analysis = [transenergycoeff, b, vel_rel, rotenergy];









