function [v,x] = GetNextVelocityAndPosition(v,x,Fg,Fb,Feb,M,dt)
    a = (Fg - Fb - Feb)/M;
    v = v + a*dt;
    x = x + v*dt;
end