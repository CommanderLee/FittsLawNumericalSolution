% Evaluate the results of the Two-Submovement model.

InputFileName = 'result8.csv';
OutputFileName = 'evaluation8.csv';
isPlot = 1;

% A W k ER ER1 ER2 T T_ MT
% skip the title
mat = csvread(InputFileName, 1, 0);

% sort by k and ER
sortMat = sortrows(mat, 3);
sortMat = sortrows(sortMat, 4);

[sortMatR sortMatC] = size(sortMat);
currk = sortMat(1, 3);
currER = sortMat(1, 4);
st = 1;
ed = 1;
cnt = 0;

A = zeros(sortMatR, 2);
B = zeros(sortMatR, 2);
R = zeros(sortMatR, 2);
kER = zeros(sortMatR, 2);

for rr = 1:sortMatR
    if sortMat(rr, 3) ~= currk || sortMat(rr, 4) ~= currER || rr == sortMatR
        % start with new k and ER.
        if rr == sortMatR
            ed = rr;
        else
            ed = rr - 1;
        end
        cnt = cnt + 1;
        
        kER(cnt, :) = [currk currER];
        
        % Evaluate with MT = a + b*sqrt(A/W)
        X = sqrt(sortMat(st:ed, 1) ./ sortMat(st:ed, 2));
        Y = sortMat(st:ed, 9);
        p = polyfit(X, Y, 1);
        F = polyval(p, X);
        r = corrcoef(X, Y);
        
        A(cnt, 1) = [p(1, 2)];
        B(cnt, 1) = [p(1, 1)];
        R(cnt, 1) = [r(1, 2)];
        
        if isPlot
            plot(X, F, 'r');
            hold on;
            plot(X, Y, 'r.');
            hold on;
        end
        
        % Evaluate with MT = a + b*log(A/W + 1)
        X = log(sortMat(st:ed, 1) ./ sortMat(st:ed, 2) + 1);
        Y = sortMat(st:ed, 9);
        p = polyfit(X, Y, 1);
        F = polyval(p, X);
        r = corrcoef(X, Y);
        
        A(cnt, 2) = [p(1, 2)];
        B(cnt, 2) = [p(1, 1)];
        R(cnt, 2) = [r(1, 2)];
        
        if isPlot
            plot(X, F, 'b');
            hold on;
            plot(X, Y, 'b.');
            hold on;
        end
        
        st = rr;
        currk = sortMat(rr, 3);
        currER = sortMat(rr, 4);
    end
end

fid = fopen(OutputFileName, 'w');
fprintf(fid, 'k,ER,A1,B1,R1,A2,B2,R2\n');
fclose(fid);

dlmwrite(OutputFileName, [kER(1:cnt, :) A(1:cnt, 1) B(1:cnt, 1) R(1:cnt, 1) A(1:cnt, 2) B(1:cnt, 2) R(1:cnt, 2)], '-append');
A(1:cnt, :)
B(1:cnt, :)
R(1:cnt, :)