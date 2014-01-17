function out = InnerIntegrand(s, sig_)
% The inner integrand of the function. ds.
out = exp(- s^2 / (2 * sig_^2));
end