clear;
pkg load communications

% given vector u
u = [1; 0.5; 0; 0; 1; 0.8; 0.2];

% creating convolution matrix built from the vector u
H = convmtx(u, 4);

% self-choosen values
a = [1; 1; 1; 1];
h = [1; -3; 6; -4];
b = 0;

N=1000;
h_c_est = zeros(N,4);
h_o_est = zeros(N,4);

% defining gaussian noise with variance 0.01
w = wgn(10,1,1e-2,'linear');
%w = sqrt(1e-2).*randn(1,10).'; % alternative definition?

% defining the given linear model
x = H * h + w;

for i = 1:N

  % defining gaussian noise with variance 0.01
  w = wgn(10,1,1e-2,'linear');
  %w = sqrt(1e-2).*randn(1,10).'; % alternative definition?

  % defining the given linear model
  x = H * h + w;

  % constrained LS estimator for impulse response
  h_c_est(i,:) = inv(H.' * H) * H.' * x - inv(H.' * H) * a * inv(a.' * inv(H.' * H) * a) * (a.' * inv(H.' * H) * H.' * x - b);

  % ordinary LS estimator for impulse response
  h_o_est(i,:) = inv(H.' * H) * H.' * x;

end

mean_h_c_est = mean(h_c_est);
mse_c = sum((mean_h_c_est-h.').^2) / length(h)

mean_h_o_est = mean(h_o_est);
mse_o = sum((mean_h_o_est-h.').^2) / length(h)
