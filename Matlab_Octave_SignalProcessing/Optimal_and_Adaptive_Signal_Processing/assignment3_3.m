% calculation according to slide 99
clear;

A = [1 2; 3 4; 5 6; 7 8];
b = [5;11;18;23];

x_est = inv(A.' * A) * A.' * b;

% additional validation via grid-search
N=1000;
x1 = linspace(0.5,1.5,N);
x2 = linspace(1.5,3.5,N);
err = zeros(length(x1),length(x2));

for i1 = 1:N
  for i2 = 1:N
    x = [x1(i1); x2(i2)];
    er = b-A*x;
    err(i1,i2) = er.' * er;
  end
end

[i, j] = find(err == min(min(err)));
M = min(min(err));
x_opt = [x1(i); x2(j)];
