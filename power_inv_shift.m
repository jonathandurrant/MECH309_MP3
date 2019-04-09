function [eigval_shift, eigvect_shift] = power_inv_shift(C,x,mu,epsilon);

diff = 1;

%mu =   FIX ME: later we have to make sure mu=lampda2+epsilon. Like that
%we automatically get the right/accurate eigenvector v2.

y = x./norm(x);
n = size (C);
I = eye (n);
B = C - mu*I;

%maxiter = 10^9;
%iter = 0;

while diff > epsilon %&& iter <  maxiter
    eigval_shift1 = transpose(y)*C*y;
    z = B\y;
    y = ((norm(z))^(-1))*z;
    eigval_shift2 = transpose(y)*C*y;
    diff = abs(eigval_shift2 - eigval_shift1);
    %iter = iter +1;
end

eigval_shift = eigval_shift2;
eigvect_shift = y;

end

