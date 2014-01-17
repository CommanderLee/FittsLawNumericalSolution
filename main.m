% The main procedure of the numerical analysis of Fitts' Law.
Ai = [300 200 400 500];
Wi = [25];%30];
ki = [0.015]; %  0.010 0.020];
ERi = [0.04]; %  0.02 0.06];
dt = 0.01;
Ti = (0.1:dt:3.0);

[ra ca] = size(Ai);
[rw cw] = size(Wi);
[rk ck] = size(ki);
[re ce] = size(ERi);
[rt ct] = size(Ti);

isplot = 0;

global W ER2;

cntR = 0;
resN = ca * cw * ck * ce;
results = zeros(resN, 7);

for aa = 1:ca
    for ww = 1:cw
        for kk = 1:ck
            for ee = 1:ce
                
                % Calculate for 4 times to get a more precise peak.
                for ii = 1:4
                    N = ct;
                    stat = zeros(N, 7);
                    cnt = 0;
                    
                    
                    A = Ai(aa);
                    W = Wi(ww);
                    k = ki(kk);
                    ER = ERi(ee);
                    
                    for tt = 1:ct
                        T = Ti(tt);
                        T_ = 0;
                        sig = k * A / T;
                        ER1 = 2 * normcdf(-W/2, 0, sig);
                        if ER1 <= ER
                            T_ = 0;
                        else
                            ER2 = ER / ER1;
                            sig_ = fsolve(@getSig_, 10, optimset('Display', 'off'));
                            %sig_ = fsolve(@getSig_, 10, optimset('Display', 'iter'));
                            T_ = func(W, k, sig, sig_);
                        end
                        MT = T + T_;
                        cnt = cnt + 1;
                        stat(cnt, :) = [A W k ER T T_ MT];
                    end
                    
                    if isplot
                        subplot(2, 2, ii);
                        plot(stat(:, 5), stat(:, 7));
                    end
                    
                    %stat
                    [minMT loc] = min(stat(:, 7));
                    peakT = stat(loc(1), 5);
                    Ti = (peakT - 10*dt) : (dt/10) : (peakT + 10*dt);
                    dt = dt / 10;
                    [rt ct] = size(Ti);
                end
                cntR = cntR + 1;
                results(cntR, :) = stat(loc(1), :);
            end
        end
    end
end

for rr=1:resN
    fprintf('The MTmin=%f, with T=%f, T''=%f.\nConstraint: A=%f, W=%f, k=%f, ER<=%f.\n\n',...
        results(rr, 7), results(rr, 5), results(rr, 6), results(rr, 1),...
        results(rr, 2), results(rr, 3), results(rr, 4));
end

csvwrite('result.csv', results);