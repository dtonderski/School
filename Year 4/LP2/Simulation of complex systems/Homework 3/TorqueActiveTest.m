T0 = 1;

xParticles = [0 1 2];
yParticles = [0 1 -1];
phiParticles = [0, 3*pi/2, pi/2];

xDir = (xParticles-xParticles');
yDir = (yParticles-yParticles');
r = sqrt(xDir.^2 + yDir.^2);
xDirHat = xDir ./ r;
yDirHat = yDir ./ r;
vxDirHat = cos(phiParticles);
vyDirHat = sin(phiParticles);
crossProductMatrix = vxDirHat'.*yDirHat - vyDirHat'.*xDirHat;
constantFactorMatrix = (vxDirHat'.*xDirHat + vyDirHat'.*yDirHat)./r.^2;
torqueMatrix = crossProductMatrix.*constantFactorMatrix;
torqueMatrix(isnan(torqueMatrix)) = 0;
torque = sum(torqueMatrix, 2)';

%%
nParticles = 3;
for n = 1:nParticles
    for i = 1:nParticles
        if n ~= i
            v = [vxDirHat(n), vyDirHat(n), 0];
            r1 = [xDirHat(n,i), yDirHat(n,i), 0];
            crossProduct = cross(v,r1);
            assert(crossProduct(3) == crossProductMatrix(n,i))
            assert(v*r1'./r(n,i).^2 == constantFactorMatrix(n,i))
            assert(crossProduct(3) * (v*r1'./r(n,i).^2) == torqueMatrix(n,i))
        end
    end
end
