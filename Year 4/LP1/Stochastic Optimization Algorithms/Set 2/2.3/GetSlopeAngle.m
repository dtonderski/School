function alpha = GetSlopeAngle(x, iSlope, iDataSet)
% Training
if iDataSet == 1
    if iSlope == 1
        alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50);
    elseif iSlope == 2
        alpha = 5 + 3*sin(x/75) + cos(sqrt(5)*x/30);
    elseif iSlope == 3
        alpha = 4 + -2*sin(x/100) - 1*cos(sqrt(7)*x/50);
    elseif iSlope == 4
        alpha = 3 + -2*sin(x/80) + 1*cos(sqrt(2)*x/40);
    elseif iSlope == 5
        alpha = 3 + x/500 + 2*sin(x/90) + 1*cos(sqrt(3)*x/40);
    elseif iSlope == 6
        alpha = 3 + -2*sin(x/90) + -1*cos(sqrt(3)*x/70);
    elseif iSlope == 7
        alpha = 5 + 4*sin(x/20) + -1*cos(sqrt(5)*x/70);
    elseif iSlope == 8
        alpha = 3 + -2*sin(x/90) + 1*cos(sqrt(2)*x/10);
    elseif iSlope == 9
        alpha = 5 + 3*sin(x/30) + -1*cos(sqrt(3)*x/40);
    elseif iSlope== 10
        alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100);
    end
% Validation
elseif iDataSet == 2
    if iSlope == 1
        alpha = 6 - sin(x/100) + cos(sqrt(3)*x/50);
    elseif iSlope == 2
        alpha = 3 + 2*sin(x/20) + 1*cos(sqrt(5)*x/60);
    elseif iSlope == 3
        alpha = 6 + -1*sin(x/90) + 1*cos(sqrt(1)*x/100);
    elseif iSlope == 4
        alpha = 3 + 2*sin(x/50) + -1*cos(sqrt(4)*x/30);
    elseif (iSlope == 5) 
        alpha = 5 + sin(x/50) + cos(sqrt(5)*x/50);
    end 
% Test
elseif iDataSet == 3
    if iSlope == 1
        alpha = 6 - sin(x/100) - cos(sqrt(7)*x/50);
    elseif iSlope == 2
        alpha = 4 + -3*sin(x/50) + 1*cos(sqrt(6)*x/100);
    elseif iSlope == 3
        alpha = 3 + -1*sin(x/100) + 1*cos(sqrt(3)*x/60);
    elseif iSlope == 4
        alpha = 3 + 2*sin(x/100) + -1*cos(sqrt(5)*x/20);
    elseif (iSlope == 5)
        alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100);
    end
end
end
