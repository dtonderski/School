clear
clf
n = 1e5;
p = 1e-4;

tic
M = spones(sprand(n,n,p/2));
M = M + M';
%disp(length(find(M == 2)))
M(M == 2) = 1;
M = M - diag(diag(M));
toc


i = 0;
tic
[kArray, PArray] = GetPArray(M, 20);

toc
%% Graph plotting
figure(1)
clf
ShowGraph(M);
title(sprintf('n = %.0e, p = %.0e', n, p), 'interpreter', 'latex')

%% P plotting
figure(2)
clf
for k = kArray
    P_theory(k) = nchoosek(n-1, k)*p^k*(1-p)^(n-1-k);
end
hold on
plot(kArray, P_theory)
plot(kArray, PArray)
legend('Theoretical prediction', 'Degree distribution')
ylabel('P(k)')
xlabel('k')
title(sprintf('P(k) with n = %.0e, p = %.0e', n, p), 'interpreter', 'latex')


%% CDF
figure(3)
clf
cdf = GetCDF(PArray, kArray);
loglog(1-cdf, kArray)
axis equal
