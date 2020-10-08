function om1 = problem1(t,om)
    %FUNCTION Summary of this function goes here
    %   Detailed explanation goes here
    gamma=[0.265;-0.995; 0.882];
    om1=om
    om1(1)=gamma(1)*om(2)*om(3);
    om1(2)=gamma(2)*om(1)*om(3);
    om1(3)=gamma(3)*om(1)*om(2);
    
    
    end

