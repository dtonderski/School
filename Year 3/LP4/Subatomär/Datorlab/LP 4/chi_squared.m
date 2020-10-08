function chi = chi_squared(X, theta, crossection, error)
    sum = 0;
    for i = [1:size(theta)]
        theo = theo_crossection(theta(i), X);
        sum = sum + ((theo - crossection(i))./error(i)).^2;
    end
    chi = sum;
end