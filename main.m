% The main procedure of the numerical analysis of Fitts' Law.
Ai = [300];
Wi = [25];
ki = [0.015];
ERi = [0.04];
Ti = (0.3:0.01:1.0);

[ra ca] = size(Ai);
[rw cw] = size(Wi);
[rk ck] = size(ki);
[re ce] = size(ERi);
[rt ct] = size(Ti);

N = ca * cw * ck * ce * ct;

stat = zeros(N, 7);
cnt = 0;

global W ER2;

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
subplot(2, 2, 1);
plot(stat(:, 5), stat(:, 7));
stat
[peak loc] = findpeaks(-stat(:, 7))