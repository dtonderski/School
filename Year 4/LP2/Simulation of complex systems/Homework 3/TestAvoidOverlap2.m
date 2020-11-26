radius = 1;
xParticles = [0,1];
yParticles = [-1, -0.7];

figure(1)
clf
viscircles([xParticles', yParticles'], ones(size(xParticles'))*radius);
xDir = xParticles - xParticles';
yDir = yParticles - yParticles';
r = sqrt(xDir.^2 + yDir.^2);
xDirHat = xDir ./ r;
yDirHat = yDir ./ r;

figure(2)
clf
% xParticles(1) = xParticles(1) - (2*radius*xDirHat(1,2)-xDir(1,2))/2;
% xParticles(2) = xParticles(2) - (2*radius*xDirHat(2,1)-xDir(2,1))/2;
% 
% yParticles(1) = yParticles(1) - (2*radius*yDirHat(1,2)-yDir(1,2))/2;
% yParticles(2) = yParticles(2) - (2*radius*yDirHat(2,1)-yDir(2,1))/2;
[xParticles, yParticles] = AvoidOverlap(xParticles, yParticles, radius);
% xParticles(1) = xParticles(1) - (2*radius*xDirHat(1, 2) - xDir(1,2))/2;
% yParticles(row) = yParticles(col) - (2*radius*yHatDir(row, col) - yDir(row,col))/2;


viscircles([xParticles', yParticles'], ones(size(xParticles'))*radius);
