% The main procedure of the numerical analysis of Fitts' Law.
Ai = [300];
Wi = [25];
ki = [2];
ERi = [0.04];

global A W k ER T_;
t = (0:0.1:1);
stat = [];

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
                    T_ = t(tt);
                    sigma = fsolve(@func, s0, optimset('Display', 'iter'));
                    T = k * A / sigma;
                    MT = T + T_;
                    stat = [stat; A W k ER T_ MT];
                end
            end
        end
    end
end
plot(stat(:, 5), stat(:, 6));