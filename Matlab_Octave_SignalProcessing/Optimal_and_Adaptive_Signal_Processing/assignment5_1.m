% OASP UE, WS 2022/2023
% Assignment 5 - Exercise 1
% Group work

clear;
clf;

N = 10;
var_A = 1;
var = logspace(-2, 2, 100);

BMSE = (var_A * var) ./ (N * var_A + var);
ordinary = var/N;

hold on;
loglog(var,BMSE)
loglog(var,var/N)
title ("Bayesian approach vs. ordinary sample mean estimator","fontsize", 12);
xlabel ("σ^2");
ylabel ("estimator");
legend ("BMSE","ordinary","location", "northwest");
hold off;
