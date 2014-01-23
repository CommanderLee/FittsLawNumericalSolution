function out = intFunc(L)
% The integrand of the function. Use Gauss-Kronrod algorithm
global sig k sig_
out = abs(normpdf(L, 0, sig) * k * L / sig_);