a = [1 1 0 0 0];
x=0;
for i = 1:5
   x = x+2^(-i)*a(i); 
end
disp(x)