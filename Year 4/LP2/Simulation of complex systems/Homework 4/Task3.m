clear
m0 = 10;
T = 100;
n = m0 + T;
m = 5;
gamma = 3;
p = 0.1;

M0 = zeros(m0);
M0(rand(m0) < p) = 1;
M0 = M0 + M0';
%disp(length(find(M == 2)))
M0(M0 == 2) = 1;
M0 = M0 - diag(diag(M0));
[endingsList, ~] = find(M0);


M = zeros(n);
M(1:m0, 1:m0) = M0;
tic
for t = 1:T
    connections = endingsList(randi([1 length(endingsList)], 1, m));
    M(m0+t,connections) = 1;
    M(connections,m0+t) = 1;
    newEndings = find(M(m0+t,:) == 1);
    endingsList = [endingsList; newEndings'; (m0+t)*ones(length(newEndings),1)];
end
toc
figure(1)
clf
ShowGraph(M)
title(sprintf('$m0 = %d, T = %d, m = %d$', m0, T, m), 'interpreter', 'latex')


kArray = 1:n;
MSum = sum(M,2);

for k = kArray
    P(k) = length(find(MSum == k));
end
PArray = P/sum(P);
CDFTheory = (2*m^2*(kArray).^(-gamma+1));
CDFTheory = CDFTheory/CDFTheory(1);

figure(3)
clf
cdf = GetCDF(PArray, kArray);
loglog(1-cdf,kArray)
hold on
loglog(CDFTheory,kArray)
axis equal
ylabel('ICCDF(p)')
xlabel('p')
hold on
legend('Measured ICCDF','Theoretical ICCDF')
title(sprintf('$m0 = %d, T = %d, m = %d$', m0, T, m), 'interpreter', 'latex')
%%
figure(2)
clf
plot(kArray, PArray)

    