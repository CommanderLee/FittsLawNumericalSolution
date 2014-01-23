% Evaluate the results of the Two-Submovement model.

InputFileName = 'result5.csv';
OutputFileName = 'evaluation5.csv';
isPlot = 1;

% A W k ER ER1 ER2 T T_ MT
% skip the title
mat = csvread(InputFileName, 1, 0);

% Evaluate with MT = a + b*sqrt(A/W)
X = sqrt(mat(:, 1) ./ mat(:, 2));
Y = mat(:, 9);
p = polyfit(X, Y, 1);
F = polyval(p, X);
r = corrcoef(X, Y);

A = [p(1, 2)];
B = [p(1, 1)];
R = [r(1, 2)];

if isPlot
    plot(X, F, 'r');
    hold on;
    plot(X, Y, 'r.');
    hold on;
end

% Evaluate with MT = a + b*log(A/W + 1)
X = log(mat(:, 1) ./ mat(:, 2) + 1);
Y = mat(:, 9);
p = polyfit(X, Y, 1);
F = polyval(p, X);
r = corrcoef(X, Y);

A = [A; p(1, 2)];
B = [B; p(1, 1)];
R = [R; r(1, 2)];

if isPlot
    plot(X, F, 'b');
    hold on;
    plot(X, Y, 'b.');
    hold on;
end

fid = fopen(OutputFileName, 'w');
fprintf(fid, 'A,B,R\n');
fclose(fid);

dlmwrite(OutputFileName, [A B R], '-append');
A
B
R
