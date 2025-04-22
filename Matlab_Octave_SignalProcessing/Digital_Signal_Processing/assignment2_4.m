n = 10000;
T_0 = 5;
f_0 = 1 / T_0;
f = linspace(-5, 5, n);
Y = 0.5 * T_0 * (sinc(f * T_0 - 1) + sinc(f * T_0 + 1));

figure; plot(f, Y, "b-");
hold on; plot(f, zeros(1, n), "k-", "LineWidth", 1); hold off;
xlabel("f"); xticks(-5:(2 * f_0):5); ylabel("Y(f)");
title("Signal: Spectrum"); grid on;
