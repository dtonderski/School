radius = 1;
xParticles = [0.1, 3];
yParticles = [0,   1];

xStatic = [0,1.5];
yStatic = [0,1];

figure(1)
clf
viscircles([xParticles', yParticles'], ones(size(xParticles'))*radius, 'Color', 'red');
viscircles([xStatic', yStatic'], ones(size(xStatic'))*radius, 'Color', 'black');

xDir = (xStatic - xParticles');
yDir = (yStatic - yParticles');
r = sqrt(xDir.^2 + yDir.^2);
xDirHat = xDir ./ r;
yDirHat = yDir ./ r;

figure(2)
clf
% xParticles(1) = xParticles(1) - (2*radius*xDirHat(1,1)-xDir(1,1));
% xParticles(2) = xParticles(2) - (2*radius*xDirHat(2,1)-xDir(2,1));
% 
% 
% yParticles(1) = yParticles(1) - (2*radius*yDirHat(1,1)-yDir(1,1));
% yParticles(2) = yParticles(2) - (2*radius*yDirHat(2,1)-yDir(2,1));
[xParticles, yParticles] = AvoidOverlapWithPassive(xParticles, yParticles, xStatic, yStatic, radius);

viscircles([xParticles', yParticles'], ones(size(xParticles'))*radius, 'Color', 'red');
viscircles([xStatic', yStatic'], ones(size(xStatic'))*radius, 'Color', 'black');
