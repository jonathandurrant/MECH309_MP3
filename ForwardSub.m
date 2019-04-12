function y = ForwardSub (L,b)
% This function is used to solve a system of linear equations Ly=b
% L is the lower triangular matrix obtained by LU Factorization
% b is given
% y is the solution to Ly=b, and will be employed in Backwardsub

n = length(b);

y(1,1) = b(1)/L(1,1); 
for i = 2:n
    y(i,1) = ( b(i) - L(i,1:i-1)* y(1:i-1,1))./L(i,i);
end