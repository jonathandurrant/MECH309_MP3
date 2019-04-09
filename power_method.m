function [eigval_max, eigvect_max, mu] = power_method(C,x,epsilon);

diff = 1;
y = x./norm(x);
%maxiter = 10^9;
%iter = 0;

while diff > epsilon %&& iter <  maxiter
    eigval_max1 = transpose(y)*C*y;
    y = inv(norm(C*y))*C*y;
    eigval_max2 = transpose(y)*C*y;
    diff = abs(eigval_max2 - eigval_max1);
    %iter = iter +1;
end

eigval_max = eigval_max2;
eigvect_max = y;
mu = eigval_max + epsilon;

end

