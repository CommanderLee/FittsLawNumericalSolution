function out = OuterIntegrand(L, T_)
% The outer integrand of the function. dL.
global sig
out = exp(-L^2 / (2 * sig^2)) * InnerFunc(L, T_);
end