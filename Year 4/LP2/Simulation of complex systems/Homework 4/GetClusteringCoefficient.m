function coeff = GetClusteringCoefficient(M)

nominator = sum(diag(M^3));

k = sum(M, 2);
denominator = sum(k.*(k-1));
coeff = full(nominator./denominator);

end

