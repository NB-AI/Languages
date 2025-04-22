N = 128;
n = 0 : N-1;

omega_1 = 2*pi*0.1;
omega_2 = 2*pi*0.15;
x = cos(omega_1*n) + cos(omega_2*n);
X = fft(x, N/2);
mag_X = abs(X);

figure; grid on;
stem(mag_X, "o-b");
xlabel("$k$", "Interpreter", "LaTeX");
ylabel("$|X[k]|$", "Interpreter", "LaTeX");
title("Magnitude Spectrum: Rectangular Window");

w = hamming(N).';
x_w = w.*x;
X_w = fft(x_w, N/2);
mag_X_w = abs(X_w);

figure; grid on;
stem(mag_X_w, "o-r");
xlabel("$k$", "Interpreter", "LaTeX");
ylabel("$|X_{w}[k]|$", "Interpreter", "LaTeX");
title("Magnitude Spectrum: Hamming Window");

omega_1 = 2*pi*0.1;
omega_2 = 2*pi*0.2;
x = cos(omega_1*n) + cos(omega_2*n);
X = fft(x, N);
mag_X = abs(X);
mag_X_tmp = abs(fft(x, N*8));

figure; grid on; hold on;
stem(mag_X, "o-b");
plot((0 : N*8-1)/8, mag_X_tmp, "--k");
xlabel("$k$", "Interpreter", "LaTeX");
ylabel("$|X[k]|$", "Interpreter", "LaTeX");
title("Magnitude Spectrum: Rectangular Window");
