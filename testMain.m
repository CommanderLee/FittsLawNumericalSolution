% A simple test of using Gauss-Legendre quadrature.
dx = 0.001;
xk = [-0.9324695 0.9324695 -0.6612094 0.6612094 -0.2386192 0.2386192];
Ak = [ 0.1713245 0.1713245  0.3607616 0.3607616  0.4679139 0.4679139];
sum = 0.0;
for a = 0:dx:(pi / 2 - dx)
    b = a + dx;
    fprintf('a=%f, b=%f\n', a, b);
    p1 = (b - a) / 2;
    p2 = (a + b) / 2;
    for k = 1:6
        sum = sum + Ak(k) * p1 * testFunc(p1 * xk(k) + p2);
    end
end
fprintf('sum=%f\n', sum);