% The main procedure of the numerical analysis of Fitts' Law.
Ai = [300];
Wi = [25];
ki = [0.015];
ERi = [0.4];
Ti = (0.7:0.05:1.4);

[ra ca] = size(Ai);
[rw cw] = size(Wi);
[rk ck] = size(ki);
[re ce] = size(ERi);
[rt ct] = size(Ti);

N = ca * cw * ck * ce * ct;

global A W k ER T sig;

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
                    s0 = 10;
                    T = Ti(tt);
                    sig = k * A / T;
                    T_ = fsolve(@func, s0, optimset('Display', 'iter'));
                    MT = T + T_;
                    cnt = cnt + 1;
                    stat(cnt, :) = [A W k ER T T_ MT];
                end
            end
        end
    end
end
plot(stat(:, 5), stat(:, 7));
stat