function out = InnerFunc(L)
% The inner function.
% That presents the probability of error at the second chance.

global A W k T_

ds = 0.1;
% Gauss-Legendre Coefficients
xk = [-0.9324695 0.9324695 -0.6612094 0.6612094 -0.2386192 0.2386192];
Ak = [ 0.1713245 0.1713245  0.3607616 0.3607616  0.4679139 0.4679139];
sum = 0.0;
inf = max(A * 0.1, W * 1.3);

for a = (-inf):ds:(-W/2 - ds)
    b = a + ds;
    p1 = (b - a) / 2;
    p2 = (a + b) / 2;
    for k = 1:6
        s = p1 * xk(k) + p2;
        sum = sum + Ak(k) * p1 * InnerIntegrand(s, L);
    end
end
out = T_ / (sqrt(2 * pi) * k * L) * sum;

end