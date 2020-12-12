muc = 0.066;
mu = [0.065, 0.064, 0.063, 0.062, 0.061, 0.060, 0.059];
gamma = sqrt([0.000266334, 0.000638389, 0.00128266, 0.00198841, 0.00258186, 0.0035553,0.00424391]);

mudiff = muc-mu;

loglog(mudiff, gamma)

Const = polyfit(log(mudiff),log(gamma), 1);
m = Const(1);
k = Const(2);
YBL = mudiff.^m.*exp(k);
hold on
loglog(mudiff, YBL)


