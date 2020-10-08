function [position,isterminal,direction]=electronEvent(t,y)
position = y(1)^2+y(2)^2-1;
isterminal=1;
direction=1;
end