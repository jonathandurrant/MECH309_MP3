function x = BackwardSub(U,y)
% This function is used to solve a system of linear equations Ux=b
% U is the upper triangular matrix obtained by LU Factorization
% y is obtained beforehand with the FowardSub algorithm 
% x is the output x column matrix, solution to Ax=b

n = length(y);

x(n,1) = y(n)/U(n,n);
for  i = n-1:-1:1
    x(i,1) = ( y(i)-U(i,i+1:n)*x(i+1:n,1))./U(i,i);
end