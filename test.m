% Test the result of 'main.m'
global A W k ER T_ sig;
A = 300;
W = 25;
k = 0.015;
ER = 0.04;
T = 0.9;
T_ = 0;
sig = k * A / T;
% out = func(T_) + ER;
out = 1 - 2 * normcdf(-3, 0, 1);
out