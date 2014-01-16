function out = InnerIntegrand(s, L)
% The inner integrand of the function. ds.
global k T_
out = exp(- s^2 * T_^2 / (2 * k^2 * L^2));
end