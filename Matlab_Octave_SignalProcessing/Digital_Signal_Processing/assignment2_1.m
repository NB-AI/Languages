% a) plot four different functions

% formula one:
n1 = -5:10; % time vector 

part1 = dirac(n1+2);
correction_idx1 = part1 == Inf; % find Inf
part1(correction_idx1) = 1;     % set Inf to finite value

part2 =  dirac(n1-1);
correction_idx2 = part2 == Inf; % find Inf
part2(correction_idx2) = 1;     % set Inf to finite value

part3 =  dirac(n1-4);
correction_idx3 = part3 == Inf; % find Inf
part3(correction_idx3) = 1;     % set Inf to finite value

part4 = dirac(n1-7);
correction_idx4 = part4 == Inf; % find Inf
part4(correction_idx4) = 1;     % set Inf to finite value


x1 = -3*part1 + 2*part2 - part3 + 4*part4;


% formula two:
x2 = @(n1) exp(-0.3 * n1);


% formula three:
n2 = 0:256;
x3 =@(n2) 2*sin((2 * pi * 3.5 * n2 / 64));

% formula four:
x4 = @(n2) cos(9*n2/64);


% Plotting like in the assigment sheet:
subplot(1,2,1)
stem(n1,x1, Color=[0,1,0])
hold on
stem(n1,x2(n1), Color=[1,0,0])
hold off
legend('x_1[n]', 'x_2[n]',Location='northoutside')
xlabel('n');
ylabel('amplitude of signals');

subplot(1  ,2,2)
plot(n2,x3(n2), Color='magenta')
hold on
plot(n2,x4(n2),Color='blue')
hold off
legend('x_3[n]', 'x_4[n]', Location='northoutside')
xlabel('n');
ylabel('amplitude of signals');

sgtitle('Discrete time signals')


% d) Write Matlab function power
power_x3 = power_(x3(0:127));


% e) function energy
energy_x1 = energy(x1);
energy_x2 = energy(x2(n1));
energy_x3 = energy(x3(n2));
energy_x4 = energy(x4(n2));


% f) creating a table with results from d) and e)
function_names = {'x_1[n]';'x_2[n]';'x_3[n]';'x_4[n]'};
Power = [nan;nan;power_x3; nan] ;
Energy = [energy_x1; energy_x2; energy_x3; energy_x4];
T = table(Power, Energy, 'Rownames',function_names)


% functions from d) and e)
function P=power_(vector)
    P = sum(abs(vector).^2)/length(vector);
end

function W=energy(signal)
    W = sum(abs(signal).^2);
end


