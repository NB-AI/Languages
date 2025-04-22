rng default;

R = 8;
L = 1024;

b = sinc(-5 : 1/R : 5) / R;
b = b / sum(b);

x = filter([1 2 1], 1, randn(1, L));

% Increase the sampling rate of `x` by a factor of `R`,
% not by a factor of `L` as indicated on the assignment sheet
x_1 = upsample(x, R);
x_2 = filter(ones(1, length(b)) / length(b), 1, x_1);
x_3 = filter(b, 1, x_1);

X_1 = fft(x_1, L/R);
X_2 = fft(x_2, L/R);
X_3 = fft(x_3, L/R);

mag_X_1 = mag2db(abs(X_1));
mag_X_2 = mag2db(abs(X_2));
mag_X_3 = mag2db(abs(X_3));

figure; grid on; hold on;
plot(mag_X_1, ".-r")
plot(mag_X_2, ".-g")
plot(mag_X_3, ".-b")
xlabel("$k$", "Interpreter", "LaTeX");
xticks(0 : 2*R : (L/R) - 1);
ylabel("$|X[k]|$", "Interpreter", "LaTeX");
title("Magnitude Spectra in dB");
legend(["$X_1$" "$X_2$" "$X_3$"], "Interpreter", "LaTeX");
