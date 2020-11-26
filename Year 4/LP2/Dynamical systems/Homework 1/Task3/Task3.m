%% TASK 3
%% init
clear, clc
%% b

syms sigma

M = [ sigma+3, 4; -9/4, sigma-3 ];
[V, D] = eig(M);
fprintf('The eigenvalues are [%s, %s].\n', diag(D))
normalizedV = -V/norm(V);
fprintf('The eigenvector is [%s, %s].\n', normalizedV)
inverseM = inv(M);
fprintf('The inverse matrix is [%s, %s ; %s, %s]. \n\n', inverseM(1,1), inverseM(1,2), inverseM(2,1), inverseM(2,2))

%% c
syms c d
eq1 = sigma - c*d == sigma + 3;
eq2 = d^2 == 4;
eq3 = -c^2 == -(9/4);
eq4 = sigma + c*d == sigma - 3;

eq = [eq1; eq2; eq3; eq4];
S = solve(eq);
I = find(S.c > 0);
fprintf('The variable c = %s, d = %s. \n', S.c(I), S.d(I))

M = [sigma - c*d, d^2; -c^2, sigma + c*d];
[V, D] = eig(M);
fprintf('The eigenvalues are [%s, %s].\n', diag(D))
fprintf('The eigenvector is [%s, %s]/%s.\n', V, norm(V))
inverseM = inv(M);
fprintf('The inverse matrix is [%s, %s ; %s, %s]. \n', inverseM(1,1), inverseM(1,2), inverseM(2,1), inverseM(2,2))
