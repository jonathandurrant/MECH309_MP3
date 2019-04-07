function [eigval_max, eigvect_max, mu] = power_method(A,x,epsilon);

diff = 1;
y = x./norm(x);

while diff > epsilon
    eigval_max1 = transpose(y)*A*y;
    y = inv(norm(A*y))*A*y;
    eigval_max2 = transpose(y)*A*y;
    diff = abs(eigval_max2 - eigval_max1);
end

eigval_max = eigval_max2;
eigvect_max = y;
mu = eigval_max + diff;

end

