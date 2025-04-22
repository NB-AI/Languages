clear;
pkg load communications

f_s = 1000;
N = 10;
A = 1;
phi = 0;

f_0 = linspace(0,f_s/2);
n = linspace(0,N-1,N);
w = wgn(1,N,0);
crlb = zeros(1,length(f_0));

for i = 1:length(f_0)
  x = A * cos(2 * pi * (f_0(i) / f_s) * n + phi) + w;
  crlb(i) = var(w) / (A^2 * sum((2 * pi * n * (1/f_s) .* sin(2 * pi * n * f_0(i)/f_s + phi)).^2));
end

plot(f_0, crlb);
axis([0 max(f_0) 0 min(crlb)*5]);
xlabel ("\nFrequency f_0 in Hz");
ylabel ("Cramer-Rao lower bound \n\n\n");
