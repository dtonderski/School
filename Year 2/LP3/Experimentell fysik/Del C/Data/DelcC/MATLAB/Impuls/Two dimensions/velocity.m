function velocity = velocity(pos,time)
%VELOCITY Summary of this function goes here
%   Detailed explanation goes here
velocity1=[];
for i = 1:1:(length(pos)-1)
    velocity1=[velocity1; pos(i+1)-pos(i)];
end
velocity=velocity1/(time(2)-time(1));

