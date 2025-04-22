%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% preparing the functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 1000;
k = (1:N);
sigma = 1; % variance
n = randn(N, 1);

function return_w = w_LMS_normal(k,full_input_signal,current_error_value,old_w,mu=0.1,gamma=0.01,order_p=2),
    
    if (k<=order_p),
        x_window = [ones(1,order_p-k)-1, full_input_signal(1:k)];
    else
        x_window = full_input_signal(k-order_p+1:k);
    endif
    x_window = transpose(x_window(end:-1:1)); % reverse structure such that newest time point is first element
    
    
    return_w = old_w + (mu/(gamma+(transpose(x_window)*x_window))) * x_window*current_error_value;
endfunction

function return_w = w_LMS_stochastic(k,full_input_signal,current_error_value,old_w,order_p=2),

    if (k<=order_p),
        x_window = [ones(1,order_p-k)-1, full_input_signal(1:k)];
    else
        x_window = full_input_signal(k-order_p+1:k);
    endif
    x_window = transpose(x_window(end:-1:1)); % reverse structure such that newest time point is first element
        
    return_w = old_w + (1/k) * x_window * current_error_value;
endfunction

function return_pred = filter_out(k,filter,full_input_signal,order_p=2),
    if (k<=order_p),
        x_window = [ones(1,order_p-k)-1, full_input_signal(1:k)];
    else
        x_window = full_input_signal(k-2+1:k);
        x_window
    endif

    x_window = transpose(x_window(end:-1:1)); % reverse structure such that newest time point is first element
    x_window
    return_pred = transpose(x_window) * filter
endfunction

function return_y = y(k,full_input_signal,current_noise_value,h_trans=[10,3],order_p=2),
    if (k<=order_p),
        x_window = [ones(1,order_p-k)-1, full_input_signal(1:k)];
    else
        x_window = full_input_signal(k-2+1:k);
    endif
    x_window = transpose(x_window(end:-1:1)); % reverse structure such that newest time point is first element

    return_y = h_trans * x_window + current_noise_value
endfunction

signal1 = 0.1 * cos(pi*k/(N/10));
signal2 = 0 + sqrt(1) * transpose(randn(N,1));

function return_mse = current_mse_value(y,y_est),
    return_mse = (y-y_est).^2; % for LMS lecture 04, page 35
endfunction

function return_lms_error = current_lms_error_value(y,y_est),
    return_lms_error = y-y_est % for LMS lecture 04, page 22
endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Generate the needed data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
order_p = 2;
initialization = ones(order_p,1)-1; % lecture 04, page 22
w_ONE = initialization; % because initialization of x is also 0
w_TWO = initialization; 
w_THREE = initialization; 
w_FOUR = initialization; 

collect_error_normal_signal1 = [];
collect_w0_normal_signal1 = [];
collect_w1_normal_signal1 = [];
collect_pred_normal_signal1 = [];
collect_y_signal1 = [];

collect_error_stochastic_signal1 = [];
collect_w0_stochastic_signal1 = [];
collect_w1_stochastic_signal1 = [];
collect_pred_stochastic_signal1 = [];

collect_error_normal_signal2 = [];
collect_w0_normal_signal2 = [];
collect_w1_normal_signal2 = [];
collect_pred_normal_signal2 = [];
collect_y_signal2 = [];

collect_error_stochastic_signal2 = [];
collect_w0_stochastic_signal2 = [];
collect_w1_stochastic_signal2 = [];
collect_pred_stochastic_signal2 = [];


% lecture 04, page 22:
for k_=1:N,

    % ONE: NORMALIZED ALGORITHM SIGNAL 1
    % First produce filter outputs:

    pred_ONE = filter_out(k_,w_ONE,signal1);

    collect_pred_normal_signal1 = [collect_pred_normal_signal1, pred_ONE];

    % Secondly, calculate the error value:
    y_val_signal1 = y(k_,signal1,n(k_));
    collect_y_signal1 = [collect_y_signal1, y_val_signal1];
    
    error_ONE = current_mse_value(y_val_signal1,pred_ONE);
    
    collect_error_normal_signal1 = [collect_error_normal_signal1, error_ONE];
    
    relevant_error_ONE = current_lms_error_value(y_val_signal1,pred_ONE);
    % Finally update w:
    w_ONE =  w_LMS_normal(k_,signal1,relevant_error_ONE,w_ONE);
    
    collect_w0_normal_signal1 = [collect_w0_normal_signal1, w_ONE(1)];
    collect_w1_normal_signal1 = [collect_w1_normal_signal1, w_ONE(2)];


    % TWO: STOCHASTIC ALGORITHM SIGNAL 1

    pred_TWO = filter_out(k_,w_TWO,signal1);

    collect_pred_stochastic_signal1 = [collect_pred_stochastic_signal1, pred_TWO];

    % Secondly, calculate the error value:
    
    error_TWO = current_mse_value(y_val_signal1,pred_TWO);
    
    collect_error_stochastic_signal1 = [collect_error_stochastic_signal1, error_TWO];
    
    relevant_error_TWO = current_lms_error_value(y_val_signal1,pred_TWO);
    % Finally update w:
    w_TWO =  w_LMS_stochastic(k_,signal1,relevant_error_TWO,w_TWO);
    
    collect_w0_stochastic_signal1 = [collect_w0_stochastic_signal1, w_TWO(1)];
    collect_w1_stochastic_signal1 = [collect_w1_stochastic_signal1, w_TWO(2)];


    % THREE: NORMALIZED ALGORITHM SIGNAL 2
    % First produce filter outputs:

    pred_THREE = filter_out(k_,w_THREE,signal2);

    collect_pred_normal_signal2 = [collect_pred_normal_signal2, pred_THREE];

    % Secondly, calculate the error value:
    y_val_signal2 = y(k_,signal2,n(k_));
    collect_y_signal2 = [collect_y_signal2, y_val_signal2];
    
    error_THREE = current_mse_value(y_val_signal2,pred_THREE);
    
    collect_error_normal_signal2 = [collect_error_normal_signal2, error_THREE];
    
    relevant_error_THREE = current_lms_error_value(y_val_signal2,pred_THREE);
    % Finally update w:
    w_THREE =  w_LMS_normal(k_,signal2,relevant_error_THREE,w_THREE);
    
    collect_w0_normal_signal2 = [collect_w0_normal_signal2, w_THREE(1)];
    collect_w1_normal_signal2 = [collect_w1_normal_signal2, w_THREE(2)];


    % FOUR: STOCHASTIC ALGORITHM SIGNAL 2
    % First produce filter outputs:

    pred_FOUR = filter_out(k_,w_FOUR,signal2);

    collect_pred_stochastic_signal2 = [collect_pred_stochastic_signal2, pred_FOUR];

    % Secondly, calculate the error value:
    
    error_FOUR = current_mse_value(y_val_signal2,pred_FOUR);
    
    collect_error_stochastic_signal2 = [collect_error_stochastic_signal2, error_FOUR];
    
    relevant_error_FOUR = current_lms_error_value(y_val_signal2,pred_FOUR);
    % Finally update w:
    w_FOUR =  w_LMS_stochastic(k_,signal2,relevant_error_FOUR,w_FOUR);
    
    collect_w0_stochastic_signal2 = [collect_w0_stochastic_signal2, w_FOUR(1)];
    collect_w1_stochastic_signal2 = [collect_w1_stochastic_signal2, w_FOUR(2)];


endfor

%%%%%%%%%%%%%%%%%% Plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ONE: NORMALIZED ALGORITHM SIGNAL 1
subplot(3,2,1:2) % number rows, number columns, total position
plot(k,collect_error_normal_signal1, Color=[0,1,0])
xlabel('k as discrete time index');
ylabel('e^2[k]');
title('squared error over k');

subplot(3,2,3)
scatter( collect_w0_normal_signal1, collect_w1_normal_signal1)
hold on
scatter(10,3, Linewidth=6,Marker="+") % scatter h
hold off
%legend('estimated filter coefficients','aimed filter coefficients') %, Location='northeastoutside')
xlabel('w_0[k]');
ylabel('w_1[k]');
title('estimated filter coeff. (blue) vs. true coeff. (red)');

subplot(3,2,5:6)
plot(k,collect_y_signal1, Color='magenta')
hold on
plot(k,collect_pred_normal_signal1, Color='blue')
hold off
legend('y', 'predicted y', Location='northoutside')
xlabel('k discrete time index');
ylabel('filtered signal amplitude');
title('estimated vs. true noised signal');

print('NormalizedLMS_SignalCos.png')



% TWO: STOCHASTIC ALGORITHM SIGNAL 1
subplot(3,2,1:2) % number rows, number columns, total position
plot(k,collect_error_stochastic_signal1, Color=[0,1,0])
xlabel('k as discrete time index');
ylabel('e^2[k]');
title('squared error over k');

subplot(3,2,3)
scatter( collect_w0_stochastic_signal1, collect_w1_stochastic_signal1)
hold on
scatter(10,3, Linewidth=6,Marker="+") % scatter h
hold off
%legend('estimated filter coefficients','aimed filter coefficients') %, Location='northeastoutside')
xlabel('w_0[k]');
ylabel('w_1[k]');
title('estimated filter coeff. (blue) vs. true coeff. (red)');

subplot(3,2,5:6)
plot(k,collect_y_signal1, Color='magenta')
hold on
plot(k,collect_pred_stochastic_signal1, Color='blue')
hold off
legend('y', 'predicted y', Location='northoutside')
xlabel('k discrete time index');
ylabel('filtered signal amplitude');
title('estimated vs. true noised signal');

print('StochasticLMS_SignalCos.png')



% THREE: NORMALIZED ALGORITHM SIGNAL 2
subplot(3,2,1:2) % number rows, number columns, total position
plot(k,collect_error_normal_signal2, Color=[0,1,0])
xlabel('k as discrete time index');
ylabel('e^2[k]');
title('squared error over k');

subplot(3,2,3)
scatter( collect_w0_normal_signal2, collect_w1_normal_signal2)
hold on
scatter(10,3, Linewidth=6,Marker="+") % scatter h
hold off
%legend('estimated filter coefficients','aimed filter coefficients') %, Location='northeastoutside')
xlabel('w_0[k]');
ylabel('w_1[k]');
title('estimated filter coeff. (blue) vs. true coeff. (red)');

subplot(3,2,5:6)
plot(k,collect_y_signal2, Color='magenta')
hold on
plot(k,collect_pred_normal_signal2, Color='blue')
hold off
legend('y', 'predicted y', Location='northoutside')
xlabel('k discrete time index');
ylabel('filtered signal amplitude');
title('estimated vs. true noised signal');

print('NormalizedLMS_SignalNormal.png')



% FOUR: STOCHASTIC ALGORITHM SIGNAL 2
subplot(3,2,1:2) % number rows, number columns, total position
plot(k,collect_error_stochastic_signal2, Color=[0,1,0])
xlabel('k as discrete time index');
ylabel('e^2[k]');
title('squared error over k');

subplot(3,2,3)
scatter( collect_w0_stochastic_signal2, collect_w1_stochastic_signal2)
hold on
scatter(10,3, Linewidth=6,Marker="+") % scatter h
hold off
%legend('estimated filter coefficients','aimed filter coefficients') %, Location='northeastoutside')
xlabel('w_0[k]');
ylabel('w_1[k]');
title('estimated filter coeff. (blue) vs. true coeff. (red)');

subplot(3,2,5:6)
plot(k,collect_y_signal2, Color='magenta')
hold on
plot(k,collect_pred_stochastic_signal2, Color='blue')
hold off
legend('y', 'predicted y', Location='northoutside')
xlabel('k discrete time index');
ylabel('filtered signal amplitude');
title('estimated vs. true noised signal');

print('StochasticLMS_SignalNormal.png')

