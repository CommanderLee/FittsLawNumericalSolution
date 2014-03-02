% Observe T and T'.

InputFileName = 'result8.csv';
OutputFileName = 'observeT8.csv';

% A W k ER ER1 ER2 T T_ MT
% skip the title
mat = csvread(InputFileName, 1, 0);

AW = sortMat(:, 1) .* sortMat(:, 2);
Ak = sortMat(:, 1) .* sortMat(:, 3);
AER = sortMat(:, 1) .* sortMat(:, 4);
Wk = sortMat(:, 2) .* sortMat(:, 3);
WER = sortMat(:, 2) .* sortMat(:, 4);
kER = sortMat(:, 3) .* sortMat(:, 4);

T = sortMat(:, 7);
T_ = sortMat(:, 8);
avgT = sortMat(:, 9) ./ 2;

dt = abs(T - T_) ./ 2 ./ avgT;

newSortMat = sortrows([sortMat dt], 10);

subplot(2, 2, 1);
plot(newSortMat(:, 1), '.');
title('Subplot1: A ');

subplot(2, 2, 2);
plot(newSortMat(:, 2), '.');
title('Subplot2: W ');

subplot(2, 2, 3);
plot(newSortMat(:, 3), '.');
title('Subplot3: k ');

subplot(2, 2, 4);
plot(newSortMat(:, 4), '.');
title('Subplot4: ER ');

% sort by the result and plot it.
newSortMat = sortrows(newSortMat, -1);
newSortMat = sortrows(newSortMat, 2);
figure;
plot(newSortMat(:, 10));
title('Plot: first W then A ');

newSortMat = sortrows(newSortMat, 2);
newSortMat = sortrows(newSortMat, -1);
figure;
plot(newSortMat(:, 10));
title('Plot: first A then W ');

fid = fopen(OutputFileName, 'w');
fprintf(fid, 'A,W,k,ER,ER1,ER2,T,T'',MT,DT\n');
fclose(fid);

dlmwrite(OutputFileName, newSortMat, '-append');