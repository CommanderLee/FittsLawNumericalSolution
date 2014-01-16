function out = func(sigma)
% The main function of the project, reflect the Error Rate.

global A W k ER T_
% test
out = A / 100 + W + T_ + ER - k * sigma ^ 2;

end