function [eigval_shift,eigvect_shift] = power_inv_shift(A,x,mu,stopcrit)

diff = 1;

%mu =   FIX ME: later we have to make sure mu=lampda2+epsilon. Like that
%we automatically get the right/accurate eigenvector v2.

y = x./norm(x);
n = size (A);
I = eye (n);
B = A - mu*I;

while diff > 10^(-6)
    eigval_shift1 = transpose(y)*A*y;
    z = B\y;
    y = ((norm(z))^(-1))*z;
    eigval_shift2 = transpose(y)*A*y;
    diff = abs(eigval_shift2 - eigval_shift1);
    
end

eigval_shift = eigval_shift2;
eigvect_shift = y;

end

