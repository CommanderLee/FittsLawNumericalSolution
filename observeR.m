% Observe R ( the correlation).

InputFileName = 'evaluation8.csv';
OutputFileName = 'observeR8.csv';

% k	ER A1 B1 R1 A2 B2 R2
% skip the title
mat = csvread(InputFileName, 1, 0);

sortMat = sortrows(mat, 5);

subplot(1, 2, 1);
plot(sortMat(:, 1), '.');
title('Subplot1: k ');

subplot(1, 2, 2);
plot(sortMat(:, 2), '.');
title('Subplot2: ER ');

% sort by the result and plot it.
newSortMat = sortrows(sortMat, 1);
newSortMat = sortrows(newSortMat, 2);
figure;
plot(newSortMat(:, 5));
title('Plot: first ER then k ');

fid = fopen(OutputFileName, 'w');
fprintf(fid, 'k,ER,A1,B1,R1\n');
fclose(fid);

dlmwrite(OutputFileName, newSortMat(:, 1:5), '-append');