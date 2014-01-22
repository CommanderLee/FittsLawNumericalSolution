% The main procedure of the numerical analysis of Fitts' Law.
Ai = [300 200 400 500];
Wi = [25 30 35 40];
ki = [0.020];
ERi = [0.08];
Tleft = 0.1;
Tright = 3;
Tdepth = 20;
Tnum = 100;

resultFileName = 'result2.csv';
% dt = 0.01;
% Ti = (0.1:dt:3.0);

[ra ca] = size(Ai);
[rw cw] = size(Wi);
[rk ck] = size(ki);
[re ce] = size(ERi);

isplot = 0;

global W ER2;

cntR = 0;
resN = ca * cw * ck * ce;
results = zeros(resN, 7);

for aa = 1:ca
    for ww = 1:cw
        for kk = 1:ck
            for ee = 1:ce
                A = Ai(aa);
                W = Wi(ww);
                k = ki(kk);
                ER = ERi(ee);
                
                % The initial bound of T.
                Ta = Tleft;
                Tb = Tright;
                
                fprintf('[A=%f, W=%f, k=%f, ER<=%f] start.', A, W, k, ER);
                % Calculate for Tdepth times to get a more precise peak.
                % Using Trichotomy, calculate answer at T1=(2Ta+Tb)/3,
                % and T2=(Ta+2Tb)/3
                for ii = 1:Tdepth
                    % The first Trisection point.
                    T1 = (2*Ta + Tb) / 3;
                    T1_ = 0;
                    sig = k * A / T1;
                    ER1 = 2 * normcdf(-W/2, 0, sig);
                    if ER1 <= ER
                        T1_ = 0;
                    else
                        ER2 = ER / ER1;
                        sig_ = fsolve(@getSig_, 10, optimset('Display', 'off'));
                        % sig_ = fsolve(@getSig_, 10, optimset('Display', 'iter'));
                        T1_ = func(W, k, sig, sig_);
                    end
                    MT1 = T1 + T1_;
                    
                    % The second Trisection point.
                    T2 = (Ta + 2*Tb) / 3;
                    T2_ = 0;
                    sig = k * A / T2;
                    ER1 = 2 * normcdf(-W/2, 0, sig);
                    if ER1 <= ER
                        T2_ = 0;
                    else
                        ER2 = ER / ER1;
                        sig_ = fsolve(@getSig_, 10, optimset('Display', 'off'));
                        % sig_ = fsolve(@getSig_, 10, optimset('Display', 'iter'));
                        T2_ = func(W, k, sig, sig_);
                    end
                    MT2 = T2 + T2_;
                    
                    if MT1 > MT2
                        Ta = T1;
                    else
                        Tb = T2;
                    end
                end
                
                dt = (Tb - Ta) / Tnum;
                Ti = (Ta:dt:Tb);
                [rt ct] = size(Ti);
                
                N = ct;
                stat = zeros(N, 7);
                cnt = 0;
                for tt=1:ct
                    T = Ti(tt);
                    T_ = 0;
                    sig = k * A / T;
                    ER1 = 2 * normcdf(-W/2, 0, sig);
                    if ER1 <= ER
                        T_ = 0;
                    else
                        ER2 = ER / ER1;
                        sig_ = fsolve(@getSig_, 10, optimset('Display', 'off'));
                        % sig_ = fsolve(@getSig_, 10, optimset('Display', 'iter'));
                        T_ = func(W, k, sig, sig_);
                    end
                    MT = T + T_;
                    
                    cnt = cnt + 1;
                    stat(cnt, :) = [A W k ER T T_ MT];
                    
                    if isplot
                        subplot(2, 2, ii);
                        plot(stat(:, 5), stat(:, 7));
                    end
                end
                % stat
                [minMT loc] = min(stat(:, 7));
                
                cntR = cntR + 1;
                results(cntR, :) = stat(loc(1), :);
                fprintf('...End.\n');
            end
        end
    end
end


for rr=1:resN
    fprintf('The MTmin=%f, with T=%f, T''=%f.\nConstraint: A=%f, W=%f, k=%f, ER<=%f.\n\n',...
        results(rr, 7), results(rr, 5), results(rr, 6), results(rr, 1),...
        results(rr, 2), results(rr, 3), results(rr, 4));
end

csvwrite(resultFileName, results);