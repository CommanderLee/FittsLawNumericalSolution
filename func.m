function out = func(sigma)
% The main function of the project, reflect the Error Rate.

global A W k ER T_

dL = 0.1;
% Gauss-Legendre Coefficients
xk = [-0.9324695 0.9324695 -0.6612094 0.6612094 -0.2386192 0.2386192];
Ak = [ 0.1713245 0.1713245  0.3607616 0.3607616  0.4679139 0.4679139];
sum = 0.0;
inf = max(A * 0.2, W * 1.5);

for a = (-inf):dL:(-W/2 - dL)
    b = a + dL;
    fprintf('T_:%f, a=%f, b=%f.\n', T_, a, b);
    p1 = (b - a) / 2;
    p2 = (a + b) / 2;
    for k = 1:6
        L = p1 * xk(k) + p2;
        sum = sum + Ak(k) * p1 * OuterIntegrand(L, sigma);
    end
end
out = 1 / (sqrt(2 * pi) * sigma) * sum - ER / 4;

% test
% out = A / 100 + W + T_ + ER - k * sigma ^ 2;

end