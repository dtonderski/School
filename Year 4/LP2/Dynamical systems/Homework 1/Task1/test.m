syms h r x

f = h +x*(r-x);
eq = f == 0;
S = solve(eq);

eq2 = S(1) == S(2);


h = solve(eq2, h);

r = 1
eval(h)
