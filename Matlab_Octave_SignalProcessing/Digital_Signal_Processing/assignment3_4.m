omega_zero = 1;

function final_H=H(omega_zero, omega)
    final_H = abs(1 + -2*cos(omega_zero*j) * e^(-omega*j) + 1 * e^(-2*omega*j));
endfunction

function [final_X_ind1, final_X_ind2] = X(omega_zero, omega_)
   % my_arr = zeros(1,n+1);
    
    my_ind1 = omega_ - omega_zero; % here it is non-zero
    my_ind2 = omega_ + omega_zero;
    
    final_X_ind1 = my_ind1;
    final_X_ind2 = my_ind2;
    
    % If there is one output, put both outputs in the first output, otherwise return two outputs:
    if nargout < 1
        final_X_ind1 = [final_X_ind1; final_X_ind2];
    end
    
endfunction

% Find out H and X:
H_arr = [];
x_ind_list = [];
omega_arr = -pi:pi;
for omega = omega_arr;
    final_H=H(omega_zero, omega);
    H_arr = [H_arr, final_H];
    
    my_ind1 = omega - omega_zero; % here it is non-zero
    my_ind2 = omega + omega_zero;
    x_ind_list = [x_ind_list, my_ind1, my_ind2]  ;
end
y_value_list = abs(x_ind_list * pi);

% Sort the values for X by size to get a clean function plot:
[X_ind_sorted, indices] = sort(x_ind_list);
X_y_sorted =y_value_list(indices);

plot(omega_arr, H_arr)
hold on 
plot(X_ind_sorted, X_y_sorted)
legend('|H(e^{ j \Omega})|','|X(e^{ j \Omega})|')
xlabel('\Omega')
ylabel('amplitude')
print assignment3_4.png


