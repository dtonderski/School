function [xParticles, yParticles, phiParticles] = GetParticleNext1(xParticles, yParticles, vParticles, phiParticles, diffusionTrans, diffusionRot, dt, nParticles)
dxdtParticles   = vParticles.*cos(phiParticles) +   sqrt(2*diffusionTrans)*normrnd(0,1,size(xParticles));
dydtParticles   = vParticles.*sin(phiParticles) +   sqrt(2*diffusionTrans)*normrnd(0,1,size(yParticles));
dphidtParticles =                                   sqrt(2*diffusionRot  )*normrnd(0,1,size(phiParticles));

xParticles      = xParticles    + dxdtParticles*    dt;
yParticles      = yParticles    + dydtParticles*    dt;
phiParticles    = phiParticles  + dphidtParticles*  dt;
end

