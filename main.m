% The main procedure of the numerical analysis of Fitts' Law.
Ai = [300];
Wi = [25];
ki = [0.015];
ERi = [0.4];
Ti = (0.1:0.1:1);

[ra ca] = size(Ai);
[rw cw] = size(Wi);
[rk ck] = size(ki);
[re ce] = size(ERi);
[rt ct] = size(Ti);

N = ca * cw * ck * ce * ct;

global A W k ER T sigma;

stat = zeros(N, 7);
cnt = 0;

for aa = 1:1
    for ww = 1:1
        for kk = 1:1
            for ee = 1:1
                A = Ai(aa);
                W = Wi(ww);
                k = ki(kk);
                ER = ERi(ee);
                
                for tt = 1:10
                    s0 = 5;
                    T = Ti(tt);
                    sigma = k * A / T;
                    T_ = fsolve(@func, s0, optimset('Display', 'iter'));
                    MT = T + T_;
                    cnt = cnt + 1;
                    stat(cnt, :) = [A W k ER T T_ MT];
                end
            end
        end
    end
end
plot(stat(:, 5), stat(:, 6));
stat