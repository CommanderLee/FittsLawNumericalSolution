% Evaluate the results of the Two-Submovement model.

InputFileName = 'result2.csv';
OutputFileName = 'evaluation2.csv';
isPlot = 1;

% A W k ER T T_ MT
mat = csvread(InputFileName);

% Evaluate with MT = a + b*sqrt(A/W)
X = sqrt(mat(:, 1) ./ mat(:, 2));
Y = mat(:, 7);
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
Y = mat(:, 7);
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

csvwrite(OutputFileName, [A B R]);
A
B
R
