function out = InnerIntegrand(s, L, T_)
% The inner integrand of the function. ds.
global k
out = exp(- s^2 * T_^2 / (2 * k^2 * L^2));
end