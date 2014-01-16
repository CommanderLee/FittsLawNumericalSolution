function out = OuterIntegrand(L, sigma)
% The outer integrand of the function. dL.
out = exp(-L^2 / (2 * sigma^2)) * InnerFunc(L);
end