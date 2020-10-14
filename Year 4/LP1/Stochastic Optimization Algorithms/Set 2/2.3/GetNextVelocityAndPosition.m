function [v,x] = GetNextVelocityAndPosition(v,x,alpha,gravityForce,brakingForce,engineBrakingForce,m,dt)
    a = (gravityForce - brakingForce - engineBrakingForce)/m;
    v = v + a*dt;
    x = x + v*cosd(alpha)*dt;
end