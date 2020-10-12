function [v,x] = GetNextVelocityAndPosition(v,x,gravityForce,brakingForce,engineBrakingForce,m,dt)
    a = (gravityForce - brakingForce - engineBrakingForce)/m;
    v = v + a*dt;
    x = x + v*dt;
end