% a)
graphics_toolkit ("gnuplot");
% pkg install -forge symbolic
pkg load symbolic
pkg list

figure(1)
stem([-6,-4,4,6],[0.5,0.5,-0.5,-0.5])
xlim([-10,10])
ylim([-1,1])
title('spectrum of sin(2\pi 4kHz t) + sin(2 \pi 6kHz t)')
xlabel('f in kHz');
ylabel('Im{X(f)}');
print assignment4_1a.png


% b)

% imaginary part:
fs = 10; % kHz, all is in kHz therefore ignore the k=1000
collect_x = [];
collect_y = [];

ind_collector2 = [];
f1 =4;
f2=6;
ind_plus_fs = [];
y_plus_fs = [];

ind_minus_fs = [];
y_minus_fs = [];


% Shift by +fs:
ind1 = f1-fs;
ind2 = -f1-fs;
ind3 = f2-fs;
ind4 = -f2-fs;
ind_plus_fs=[ind_plus_fs,ind2,ind4,ind1,ind3];
y_plus_fs = [y_plus_fs, 0.5,0.5,-0.5,-0.5];%*fs;

% Shift by -fs:
ind1 = f1+fs;
ind2 = -f1+fs;
ind3 = f2+fs;
ind4 = -f2+fs;
ind_minus_fs=[ind_minus_fs,ind2,ind4,ind1,ind3];
y_minus_fs = [y_minus_fs,0.5,0.5,-0.5,-0.5];%*fs;

% Shift by 0:
ind1 = f1;
ind2 = -f1;
ind3 = f2;
ind4 = -f2;
    
% Sort the values for X by size to get a clean function plot:
[X_ind_sorted2, indices2] = sort(ind_plus_fs);
X_y_sorted2 = y_plus_fs (indices2);

% Sort the values for X by size to get a clean function plot:
[X_ind_sorted3, indices3] = sort(ind_minus_fs);
X_y_sorted3 = y_minus_fs(indices3);

% Sort the values for X by size to get a clean function plot:
[X_ind_sorted4, indices4] = sort([ind_plus_fs, [-6,-4,4,6], ind_minus_fs]);
X_y_sorted4 = [y_plus_fs, [0.5,0.5,-0.5,-0.5], y_minus_fs](indices4);


final_collector2= [];
final_collector3= [];
final_collector4= [];
final_x = -fs:fs;
for x = final_x
    
    final_value2 =  sum(X_y_sorted2(X_ind_sorted2==x));
    final_collector2 = [final_collector2, final_value2];
    
    final_value3 =  sum(X_y_sorted3(X_ind_sorted3==x));
    final_collector3 = [final_collector3, final_value3];
    
    final_value4 = sum(X_y_sorted4(X_ind_sorted4==x));
    final_collector4 = [final_collector4, final_value4];
end  


%x_axis = 0:length(final_array)-1;
figure(2)
stem([-6,-4,4,6],[0.5,0.5,-0.5,-0.5], 'Linewidth',3);
xlim([-10,10]);
ylim([-10,10]);
title('shifted spectra with original signal x(t)=sin(2\pi 4kHz t) + sin(2 \pi 6kHz t)')
xlabel('f in kHz');
ylabel('Im{X(f)}');

hold on
%stem(ind_plus_fs, y_plus_fs);%
stem(final_x, final_collector2, 'Linewidth',2);

hold on
%stem(ind_minus_fs, y_minus_fs);%
stem(final_x, final_collector3, 'Linewidth',1);

hold on
stem(final_x, final_collector4 *fs, 'Linewidth',1);

legend('unshifted','f_s shifted','-f_s shifted','spectrum of x[n]');
print assignment4_1b1.png

% real part:
figure(3)
real_ar = zeros(1,length(final_x));
stem(final_x,real_ar, 'Linewidth',3)
hold on 
stem(final_x,real_ar, 'Linewidth',3)
hold on 
stem(final_x,real_ar, 'Linewidth',3)
hold on 
stem(final_x,real_ar, 'Linewidth',3)

xlim([-10,10]);
ylim([-10,10]);
title('shifted spectra with original signal x(t)=sin(2\pi 4kHz t) + sin(2 \pi 6kHz t)')
xlabel('f in kHz');
ylabel('Re{X(f)}');
legend('unshifted','f_s shifted','-f_s shifted','spectrum of x[n]');
print assignment4_1b2.png

% c)

% x(t) first 2 ms:
f1 =4;
f2=6;
n=1:200;
signal = sin(2 *pi* f1 *n) + sin(2 *pi *f2 *n);

% x[n]:
graphics_toolkit ("gnuplot");
%pkg install -forge statistics
%pkg install -forge io
pkg load statistics;
pkg list

sampled_indices = sort(randsample(n,20));
sampled_signal = sin(2 *pi* f1 *sampled_indices) + sin(2 *pi *f2 *sampled_indices);

% plot both:
figure(4)
plot(n, signal)
hold on
plot(sampled_indices, sampled_signal,'.-')
title('Visualizing first 2 ms of the signal x(t)=sin(2\pi 4kHz t) + sin(2 \pi 6kHz t)')
ylabel('Amplitude of the signal')
xlabel('n')
legend('x(t)','x[n] with F_s=10kHz')
print assignment4_1c.png
