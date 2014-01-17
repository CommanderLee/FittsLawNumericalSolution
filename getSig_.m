function out = getSig_(sig_)
% This function is for solving the following formular of sigma'.
global W ER2
out = 2 * normcdf(-W/2, 0, sig_) - ER2;
end