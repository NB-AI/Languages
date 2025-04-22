%pkg install -forge 'control'
%pkg install -forge 'signal'

pkg load 'signal' % to use xcorr()

% given:
N = 1000;
i = (1:N)'; % i is our k here 
s = 10 * sin(2* pi *i/(N /5));
n = randn(N, 1);

% hyperparameters:
p = 20;
k_0 = [0, 1, 5, 10, 15, p-1]; % k_0 should be smaller than p

% initialize signals:
x = s(i) + n(i);

function return_ = y(current_time_ind,shift,number_samples),
    return_ = 10 * sin(2* pi *(current_time_ind-shift)/(number_samples /5));
endfunction

% estimate filter w:
y_pred_all = ones(length(k_0),N);
counter_k0 = 0;
for k0=k_0,
    k0
    counter_k0 += 1;
    k_start = 1 + k0; % because y[k]=s[k-k_0] -> k-k_0=1 -> k=1+k_0
    k_start
    
    counter_kth_output = 0;
    for k=k_start:N,
    
        counter_kth_output += 1;

        % determine the x_window which depends on the length of w:
        if (k-p+1<1) % current k is smaller than the length of filter w, consequence: full filter length not reached
            % we can jump to next higher k in for loop or (like here) go on with a smaller w
            start_ind = 1;
        elseif (p==1) % derived from k-p+1==k; p = 1 and therefore the x_window only has one ele
            start_ind = k;
        else % the normal case
            start_ind = k-p+1;
        endif
  
        #if (k-p+1>0) % then the whole filter w of length p will be used to estimate output
        x_window = x(start_ind:k);
        x_window = x_window(end:-1:1); % reverse structure such that newest time point is first element

        % compute r_xy, R_xx, w:
        y_current = y(k,k0,N);

        if (length(x_window)>1)
            r_xy = xcorr(X=x_window, Y=[y_current,ones(1,length(x_window)-1)-1]); # one single value, depends on y value if errormessage
            r_xy = r_xy(length(r_xy)-length(x_window)+1:length(r_xy));
            %r_xy = r_xy'; % ' to convert shape from 1xm to mx1

            R_xx_first_row = xcorr(X=x_window, Y=[x_window(1),ones(1,length(x_window)-1)-1]); % Y gives us scalar x[k]
            R_xx_first_row = R_xx_first_row(length(R_xx_first_row)-length(x_window)+1:length(R_xx_first_row));
            R_xx = toeplitz(r=R_xx_first_row); % r as row

            w = inv(R_xx) * r_xy; 
            
        else % x_window has only size of 1
            r_xy = xcorr(X=[x_window,0], Y=[y_current,0]);
            r_xy = r_xy(2);
            
            R_xx = xcorr(X=[x_window,0], Y=[x_window,0]); % Y gives us scalar x[k]
            R_xx = R_xx(2);
            w = (1/R_xx) * r_xy; 

        endif
        
        % estimate w and y:
        y_pred = w' * x_window;
        y_pred_all(counter_k0, counter_kth_output) = y_pred;
        
    endfor

endfor

% plot results
shift_ind = 0;
for shift=k_0,
    shift_ind += 1;
    figure(1)
    plot(i,s, 'LineWidth',0.5,'Color',[0 1 0]) 
    hold on % add further graphs into one plot
    plot(i,x, 'LineWidth',0.5,'Color',[0 0 1]) 
    plot(i,y(i,shift,N), '--.r','LineWidth',0.5,'Color',[0 1 1]) 
    plot(i,y_pred_all(shift_ind,:), '--.r','LineWidth',0.5,'Color',[1 0 1]) 
    hold off

    % description plot:
    xlabel('sample indices');
    ylabel('amplitude');
    legend('original signal','original signal with noise','delayed original signal', 'predicted signal for shift')
    title(['Wiener filter for noise reduction shift of signal by ' num2str(shift)]);
    grid on;

    % store image:
    f_name = ['ex4_wiener_filter_shiftOf' num2str(shift) '.png'];
    print(f_name)
endfor
