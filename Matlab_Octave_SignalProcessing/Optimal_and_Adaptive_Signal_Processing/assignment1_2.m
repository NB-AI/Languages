% (a) Plot child birth rate over number of storks
child_birth_rate = [87 610 82 124 439 106 120 59];
storks = [300 30000 150 5000 8000 2500 1500 9];

scatter(child_birth_rate, storks);
% description plot:
xlabel('Child birth rate (10^3/Year)');
ylabel('Number of Storks');
title('Child birth rate over number of storks')
grid on;
print problem6.png;


% (b) Computing the correlation coefficent:
child_mean = mean(child_birth_rate);
storks_mean = mean(storks);

covariance = cov(child_birth_rate, storks);
var_child = std(child_birth_rate )^2;
var_storks = std(storks)^2;

corr_coefficient = covariance/sqrt(var_child * var_storks);
disp("Correlation coefficient = ");
disp(corr_coefficient);

% (c) correlation coefficent between area and stork number:
area = [83860 312680 41290 93000 504750 132000 92390 43100];

covariance2 = cov(area, storks);
var_area = std(area)^2;

corr_coefficient2 = covariance2/sqrt(var_area * var_storks);
disp("Correlation coefficient = ");
disp(corr_coefficient2);
