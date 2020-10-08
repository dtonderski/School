function y1 = problem1(t,y)
%PROBLEM1 En ekvation som beskriver en elektrons bana inom en cirkel
%   Ekvationen är på formeln y'=Ay+B
%inom cirkeln
A=[0 0 1 0; 0 0 0 1; 0 0 0 1; 0 0 -1 0];
B=[0; 0; 1; 0];
%utanför cirkeln
A1=[0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0];
if y(1)^2+y(2)^2>1
    y1=A1*y;
else
    y1=A*y+B;

end

