clear;
close all;
clf reset;
pkg load communications

% given parameters
N = 10;
var_x = 9;
n_runs = 10;

% to increase resolution
n_dots = 1e2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% range of variance where the grid-search is performed on
var_range = linspace(0.1, 3*var_x, n_dots);

% helping variable
p_sigma = zeros(n_runs, length(var_range));

figure(1);
hold on

for j = 1:n_runs

  %x = wgn(1,N,var_x,'linear');
  x = sqrt(var_x)*randn(1,N);

  for i = 1:n_dots
    p_sigma(j,i) = (1 / (2 * pi * var_range(i)).^(N/2)) * e.^(-(1/(2*var_range(i))) * sum((x-mean(x)).^2));
  end

  i_max = find(p_sigma(j,:) == max(p_sigma(j,:)));
  plot(var_range, p_sigma(j,:));
  plot([var_range(i_max) var_range(i_max)],[min(p_sigma(j,:)((isfinite(p_sigma(j,:))))) max(p_sigma(j,:))]);

end

hold off
xlim([min(var_range) max(var_range)]);
%ylim([min(p_sigma(j,:)((isfinite(p_sigma(j,:))))) max(max(p_sigma))]);
title(sprintf('\sigma^2 estimator likelihood function of %d runs', n_runs),'FontSize', 12);
xlabel ("\n var");
ylabel ("p(x;var) \n\n\n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% range of variance where the grid-search is performed on
var_range = logspace(-2, 7, n_dots);

% helping variable
p_power = zeros(n_runs, length(var_range));

figure(2);
hold on

for j = 1:n_runs

  %x = wgn(1,N,var_x,'linear');
  x = sqrt(var_x)*randn(1,N);

  for i = 1:n_dots
      p_power(j,i) = 10 * log10((1. / (2 * pi * var_range(i)).^(N/2)) * e.^(-(1/(2*var_range(i))) * sum((x-mean(x)).^2)));
  end

  i_max = find(p_power(j,:) == max(p_power(j,:)));
  plot(var_range, p_power(j,:));
  plot([var_range(i_max) var_range(i_max)],[min(p_power(j,:)((isfinite(p_power(j,:))))) max(p_power(j,:))]);

end

hold off
set(gca, 'XScale', 'log');
xlim([min(var_range) max(var_range)]);
ylim([0.8*min(p_power((isfinite(p_power)))) max(max(p_power))]);
title(sprintf('P estimator likelihood function of %d runs', n_runs),'FontSize', 12);
xlabel ("\n var");
ylabel ("p(x;var) \n\n\n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
