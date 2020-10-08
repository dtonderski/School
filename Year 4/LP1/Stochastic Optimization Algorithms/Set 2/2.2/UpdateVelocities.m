function velocity = UpdateVelocities(velocity, position, c1, c2, deltat, particleBestPosition, globalBestPosition, w)
[NParticles, n] = size(velocity);
for j = 1:n
    q = rand(NParticles,1);
    firstTerm = c1.*q.*(particleBestPosition(:,j)-position(:,j))./deltat;
    r = rand(NParticles,1);
    secondTerm = c2.*r.*(globalBestPosition(j) - position(:,j))./deltat;
    velocity(:,j) = w*velocity(:,j) + firstTerm + secondTerm;
end
end

