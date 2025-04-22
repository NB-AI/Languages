disp("Running script for assignment 6 task 1")
function out=funct_name(N)
    array=[];
    for n = N
        sum = 0;
        for i=[1:4]
            sum_part = (1/(2*i-1)) * sin(2*pi*0.005*(2*i-1)*n);
            sum = sum + sum_part;
        end
        array = [array, sum];
    end
    out = array;
endfunction

signal = funct_name([0:3*199]);

load('Filter_coefficients.mat')

fir = filter(b1,a1,signal); 
iir = filter(b2,a2,signal);

% Visualizing the b coefficents of FIR filter:
stem(b1)
xlabel('n')
ylabel('h[n]')
title('Impulse response of FIR')
print b_fir.png

% Checking b coefficents of FIR filter in symmetry:
middle_floor = floor(length(b1)/2);
all(b1(1:middle_floor) == fliplr(b1((middle_floor+2):length(b1))))

% Visualizing original signal vs. IIR filtered signal:
plot(signal)
hold on
plot(iir)
legend('input signal','IIR filtered signal')
xlabel('n')
ylabel('amplitude')
print signal_iir.png

