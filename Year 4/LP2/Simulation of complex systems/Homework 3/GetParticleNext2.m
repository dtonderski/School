function [xParticles, yParticles, phiParticles] = GetParticleNext2(xParticles, yParticles, vParticles, phiParticles, diffusionTrans, diffusionRot, torqueConstant, dt, bounceOfWalls, xRange, yRange)
dxdtParticles   = vParticles.*cos(phiParticles) +   sqrt(2*diffusionTrans)*normrnd(0,1,size(xParticles  ));
dydtParticles   = vParticles.*sin(phiParticles) +   sqrt(2*diffusionTrans)*normrnd(0,1,size(yParticles  ));
dphidtParticles =                                   sqrt(2*diffusionRot  )*normrnd(0,1,size(phiParticles));

torque = GetTorqueActive(xParticles, yParticles, phiParticles, torqueConstant);
%disp(max(max(torque)))
dphidtParticles = dphidtParticles + torque;


xParticles      = xParticles    + dxdtParticles*    dt;
yParticles      = yParticles    + dydtParticles*    dt;
phiParticles    = phiParticles  + dphidtParticles*  dt;

if bounceOfWalls
    xTooBigIndex = xParticles > xRange(2);
    phiParticles(xTooBigIndex) = pi;

    xTooSmallIndex = xParticles < xRange(1);
    phiParticles(xTooSmallIndex) = 0;

    yTooBigIndex = yParticles > yRange(2);
    phiParticles(yTooBigIndex) = 3*pi/2;

    yTooSmallIndex = yParticles < yRange(1);
    phiParticles(yTooSmallIndex) = pi/2;
end

end

function torque = GetTorqueActive(xParticles, yParticles, phiParticles, torqueConstant)
    xDir = (xParticles-xParticles');
    yDir = (yParticles-yParticles');
    r = sqrt(xDir.^2 + yDir.^2);
    xDirHat = xDir ./ r;
    yDirHat = yDir ./ r;
    vxDirHat = cos(phiParticles);
    vyDirHat = sin(phiParticles);
    
    crossProductMatrix = vxDirHat'.*yDirHat - vyDirHat'.*xDirHat;
    scalarFactorMatrix = (vxDirHat'.*xDirHat + vyDirHat'.*yDirHat)./r.^2;
    torqueMatrix = torqueConstant * crossProductMatrix.*scalarFactorMatrix;
    torqueMatrix(isnan(torqueMatrix)) = 0;
    torque = sum(torqueMatrix, 2)';
end