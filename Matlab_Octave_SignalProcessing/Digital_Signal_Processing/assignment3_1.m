graphics_toolkit ("gnuplot");
% pkg install -forge symbolic
pkg load symbolic;
pkg list

function final_sum=h(g, n)
    final_sum = 0;
    my_arr = zeros(1,n+1); % +1 because we start at index 1
    
    for k = 0:n
        my_ind = (n-abs(k-n)) ;
        sum_ = ((1-g) * g^(n-k));
        my_arr(my_ind+1) = sum_; # octave array slicing starts with 1, not 0
    end
    final_sum=my_arr;    
endfunction

result_array = []; 
final_n = 20;

g=0.2
subplot(2,2,1) # object overlays 1 row location, 2 column locations; is at position 1
final_array = h(g,final_n);
x_axis = 0:length(final_array)-1;
stem(x_axis,final_array)%, Color=[0,1,0])
title('h[20] with g=0.2')
xlabel('n');
ylabel('h[n]');

g=0.5
subplot(2,2,2) 
final_array = h(g,final_n);
stem(x_axis,final_array)%, Color=[0,1,0])
title('h[20] with g=0.5')
xlabel('n');
ylabel('h[n]');

g=0.8
subplot(2,2,3) 
final_array = h(g,final_n);
stem(x_axis,final_array)%, Color=[0,1,0])
title('h[20] with g=0.8')
xlabel('n');
ylabel('h[n]');

print assignment3_1.png


