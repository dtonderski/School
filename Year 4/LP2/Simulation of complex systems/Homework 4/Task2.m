clear
n = 20;
p = 0.1;
c = 6;

M = zeros(n);

for i = 1:n
    for j = 1:c/2
        if i-j < 1
            M(i, n+i-j) = 1;
            M(i, i+j) = 1;

        elseif i+j > n
            M(i,i-j) = 1;
            M(i, i+j-n) = 1;

        else
            M(i, i-j) = 1;
            M(i,i+j) = 1;
            
        end
    end
end

figure(1)
clf
ShowGraph(M)
title(sprintf('Before adding shortcuts, $n = %d, c = %d$', n, c), 'interpreter', 'latex')

for k = 1:n*c/2
    if rand < p
        i = randi([1 n]);
        j = randi([1 n]);
        M(i,j) = 1;
        M(j,i) = 1;
    end
end

figure(4)
clf
ShowGraph(M)

title(sprintf('After adding shortcuts, $n = %d, c=%d, p = %.1f$', n,c, p), 'interpreter', 'latex')

%% P
figure(2)
clf
[kArray, PArray] = GetPArray(M, 20);
plot(kArray, PArray)

%% CDF
figure(3)
clf
cdf = GetCDF(PArray, kArray);
loglog(1-cdf, kArray)
axis equal