L_h = 3;
h = [0.25 0.5 0.25];

L_x = 50;
x = cos(0.1 * pi * 0:(L_x - 1));

L_y = L_x + L_h - 1;
y = zeros(1, L_y);

for n = 1:L_y
    for i = 1:L_h
        j = n - i + 1;
        if 1 <= j && j <= L_x
            y(n) = y(n) + h(i) * x(j);
        end
    end
end

n = 0:(L_y - 1);
figure; stem(n, y, "b-o");
xlabel("n"); xticks(n(1:5:end)); ylabel("y[n]");
title("Output Signal"); grid on;

figure; stem(n, y, "b-o");
hold on; stem(n, conv(x, h), "r--x"); hold off;
xlabel("n"); xticks(n(1:5:end)); ylabel("y[n]");
title("Output Signal: Custom vs. Built-in");
legend("Custom", "Built-in"); grid on;
