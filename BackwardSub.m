function x = BackwardSub(U,b)
% this function is used to solve a system of linear eqs. ax=b
% where U is the upper triangular matrix

% Input variables
% U whihc is found from LU_factorization
% b which is the in put given from the y column vector which is obtained
% from ForwardSub

% Output x column matrix

n = length(b);

x(n,1) = b(n)/U(n,n);
for  i = n-1:-1:1
    x(i,1) = ( b(i)-U(i,i+1:n)*x(i+1:n,1))./U(i,i);

end