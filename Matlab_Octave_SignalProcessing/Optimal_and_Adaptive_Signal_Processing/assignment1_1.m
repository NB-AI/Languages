% OASP UE, WS 2022
% Assignment 1 - Exercise 5
% Group work (2 students)

% a)
M = 10_000; % selected higher M in order to stabilize outcome
x = rand(1,M); % generate M random uniformly distributed values in range (0,1)
x(x<=5/16) = 0; % as of 1/16 + 1/4 = 5/16, set all values <= 5/16 to 0
x(x>5/16) = 1; % set all values > 5/16 to 1
y = rand(1,M); % generate M random uniformly distributed values in range (0,1)
y(y<=3/16) = 0; % as of 1/16 + 1/8 = 3/16, set all values <= 3/16 to 0
y(y>3/16) = 1; % set all values > 3/16 to 1

% b)
value = [sum(~x.*~y) sum(~x.*y); sum(x.*~y) sum(x.*y)]; % creating PMF (0 & 1 counts for x and y each)
p_xy_hat = value/M; % normalizing by M

% c)
p_x_hat = p_xy_hat(1,:); % extracting the entries for x
p_y_hat = p_xy_hat(2,:); % extracting the entries for y

% d)
x_ = mean(x); % pre-calculating the mean of x
y_ = mean(y); % pre-calculating the mean of y
rho_xy_hat = mean(x.*y - x_*y_)/sqrt(mean(x.^2 - x_^2)*mean(y.^2 - y_^2)); % applying given formula
