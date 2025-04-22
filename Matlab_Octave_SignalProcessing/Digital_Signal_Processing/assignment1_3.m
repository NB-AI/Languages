
% Task 3

% b) plot f_2:

time = 0:0.001:1; % time vector
x = cos(2*pi*2*time);
tau = 0.1;
x2 = cos(2*pi*2*(time-tau));
x3 = cos(2*pi*2*time + (-tau*2*pi*2));

figure(1)
plot(time,x,"Color",[0 1 0],LineWidth=3) % plot original signal
hold on % add further graphs into one plot
plot(time,x2, 'LineWidth',3,'Color',[0 0 1]) % plot time delayed signal
plot(time,x3, '--.r','LineWidth',3,'Markersize',0.05) % plot phase shifted signal
hold off

% description plot:
xlabel('time in s');
ylabel('x(time)');
legend('original signal','time delayed signal','phase shifted signal')
title('shifting effects for f_2=2Hz');
grid on;



% c) plot phi_i:

phi_1 = - tau * 2 * pi * 1;
phi_2 = - tau * 2 * pi * 2;
phi_3 = - tau * 2 * pi * 3;

x_points = [1,2,3];
y_points = [phi_1, phi_2, phi_3];


% getting linear function/line:
slope_y = y_points(1)-y_points(2);
slope_x = x_points(1)-x_points(2);
slope = slope_y / slope_x;
freq_scale = -1:3;
% generating linear function to show that points lay on line:
linear_func = @(freq) slope * freq + 0; % @(freq) such that we can put in single frequency values like linear_func(3)

disp('Check if all Phi_i lay on the linear function whose slope was built by two Phi_i and it goes through the origin:')

for index = 1:3
    if y_points(index) == linear_func(x_points(index))
        disp('point lays on line')
    else
        disp('point is not on line!')
    end
end

% plotting the results in a new figure:
figure(2)
plot(freq_scale, linear_func(freq_scale), Color=[0 1 0], Linewidth=3)
hold on
scatter(0,0, Linewidth=6,Marker="+")
scatter(x_points,y_points, Linewidth=3,Color=[0 0 1])
hold off

% description plot:
xlabel('frequency in Hz');
ylabel('Phase value \Phi');
legend('linear function', 'origin', 'Phases \Phi_i')
title('Phases \Phi_i over frequencies f_i')
grid on;

