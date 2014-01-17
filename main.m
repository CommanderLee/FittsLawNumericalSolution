% The main procedure of the numerical analysis of Fitts' Law.
Ai = [300];
Wi = [25];
ki = [0.015];
ERi = [0.04];
dt = 0.01;
Ti = (0.1:dt:3.0);

[ra ca] = size(Ai);
[rw cw] = size(Wi);
[rk ck] = size(ki);
[re ce] = size(ERi);
[rt ct] = size(Ti);

global W ER2;

% Calculate for 4 times to get a more precise peak.
for ii = 1:4
    N = ca * cw * ck * ce * ct;
    stat = zeros(N, 7);
    cnt = 0;

    for aa = 1:ca
        for ww = 1:cw
            for kk = 1:ck
                for ee = 1:ce
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
                            sig_ = fsolve(@getSig_, 10, optimset('Display', 'iter'));
                            T_ = func(W, k, sig, sig_);
                        end
                        MT = T + T_;
                        cnt = cnt + 1;
                        stat(cnt, :) = [A W k ER T T_ MT];
                    end
                end
            end
        end
    end
    subplot(2, 2, ii);
    plot(stat(:, 5), stat(:, 7));
    stat
    [peak loc] = findpeaks(-stat(:, 7));
    peakT = stat(loc, 5);
    Ti = (peakT - 20*dt) : (dt/10) : (peakT + 20*dt);
    dt = dt / 10;
    [rt ct] = size(Ti);
end