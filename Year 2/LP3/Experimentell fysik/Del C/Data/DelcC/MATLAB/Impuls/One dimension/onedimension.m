function coefficients = onedimension(path, mass1, mass2)
data=load(path);
pos_x_1 = data(:,3);
pos_x_2 = data(:,6);
time = data(:,2);


hFig = figure(1);
set(hFig, 'Position', [0 0 1920 1080])

%%tar bort NaN, skapar tidsmatriser
pos_x_1=pos_x_1(pos_x_1<1337420);
time_x_1=time(1:length(pos_x_1));
time_x_1_1=time_x_1(1:(length(time_x_1)-1)); %%För hastighet (vi har inte randvärden)

pos_x_2=pos_x_2(pos_x_2<1337420);
time_x_2=time(1:length(pos_x_2));
time_x_2_1=time_x_2(1:(length(time_x_2)-1)); %%För hastighet (vi har inte randvärden)




velocity_x_1=velocity(pos_x_1,time_x_1);
velocity_x_1col=smoothdata(velocity_x_1, 'gaussian', 40);

%subplot(1,2,1);
title('Velocity 1')
%plot(time_x_1_1,velocity_x_1);
TF = ischange(velocity_x_1col,'linear','MaxNumChanges',2);
hold on
%plot(time_x_1_1, TF*350)
%plot(time_x_1_1, -TF*350)


collision=find(TF==1);
collisionstart=collision(1);
collisionend=collision(2);

velocity_x_1=velocity(pos_x_1,time_x_1);
velocity_x_1_before=velocity_x_1(floor(collisionstart/4):collisionstart);
velocity_x_1_after=velocity_x_1(collisionend:(collisionend + floor((length(velocity_x_1)-collisionend)/4)));
meanvelocity_x_1_before = mean(velocity_x_1_before);
meanvelocity_x_1_after = mean(velocity_x_1_after);




velocity_x_2=velocity(pos_x_2,time_x_2);
velocity_x_2col=smoothdata(velocity_x_2, 'gaussian', 40);

%subplot(1,2,2);
title('Velocity 2')
%plot(time_x_2_1,velocity_x_2);
TF = ischange(velocity_x_2col,'linear','MaxNumChanges',2);
hold on
%plot(time_x_2_1, TF*350)
%plot(time_x_2_1, -TF*350)


collision=find(TF==1);
collisionstart=collision(1);
collisionend=collision(2);

velocity_x_2_before=velocity_x_2(1:floor(collisionstart/4));
velocity_x_2_after=velocity_x_2(collisionend:(collisionend + floor((length(velocity_x_2)-collisionend)/4)));
meanvelocity_x_2_before = mean(velocity_x_2_before);
meanvelocity_x_2_after = mean(velocity_x_2_after);




SIvelafter1=meanvelocity_x_1_after./1000
SIvelbefore1=meanvelocity_x_1_before./1000
SIvelafter2=meanvelocity_x_2_after./1000
SIvelbefore2=meanvelocity_x_2_before./1000

restitution_coefficient=-(SIvelafter1-SIvelafter2)/(SIvelbefore1-SIvelbefore2);
energy_before=SIvelbefore1^2*mass1/2+SIvelbefore2^2*mass2/2;
energy_after=SIvelafter1^2*mass1/2+SIvelafter2^2*mass2/2;
energy_coefficient = energy_after/energy_before;
coefficients = [energy_coefficient, restitution_coefficient, SIvelbefore1, SIvelbefore2];
end
    
