% Check your results of the first task:

% c1:
c1 = -3 + j*5;
% I checked if there are the same values:
radius = abs(c1); 
theta_euler = angle(c1); 
c1_euler = radius * exp(theta_euler);

% c2:
c2 = sqrt(2) * exp(- j*3*pi/4);

% c3:
c3 = (1/sqrt(2)) + (j/sqrt(2));

% calculations:
c4 = c1 + c2;
display(c4)
c5 = c1 * c2;
display(c5)
c6 = abs(c3)^2;
display(c6)
c7_euler = angle(c3); % c7_euler is meant to be theta information (no degree directly)
c7 = c7_euler/pi *180; % getting a degree
display(c7)
c8 = c1/c2;
display(c8)
c1_star = real(c1) + imag(c1) * (-j);
c9 = c1 * c1_star;
display(c9)
