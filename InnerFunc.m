function out = InnerFunc(L, T_)
% The inner function.
% That presents the probability of error at the second chance.

if 1
    out = 1;
else
    global W k
    
    ds = 0.1;
    % Gauss-Legendre Coefficients
    xk = [-0.9324695 0.9324695 -0.6612094 0.6612094 -0.2386192 0.2386192];
    Ak = [ 0.1713245 0.1713245  0.3607616 0.3607616  0.4679139 0.4679139];
    sum = 0.0;
    inf = max(L, W * 0.8);
    sig_ = abs(k * L / T_);
    
    for a = (-inf):ds:(-W/2 - ds)
        b = a + ds;
        p1 = (b - a) / 2;
        p2 = (a + b) / 2;
        subSum = 0.0;
        for k = 1:6
            s = p1 * xk(k) + p2;
            subSum = subSum + Ak(k) * p1 * InnerIntegrand(s, sig_);
        end
%         if subSum < 0
%             subSum
%         end
%         sum = sum + subSum;
%         if sum < 0
%             sum
%         end
    end
    out = 1 / (sqrt(2 * pi) * sig_) * sum;
%     if out < 0
%         fprintf('sum=%f, out=%f, sig_=%f, k=%f, L=%f\n', sum, out, sig_, k, L);
%     end
end

end