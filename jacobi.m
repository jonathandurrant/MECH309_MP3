function [D,T] = jacobi(A)
%JACOBI Summary of this function goes here
%   Detailed explanation goes here


%setup
n = length(A);
U = zeros(n);
L = U;
D=U;

for i = 1:n             % for each row
    D(i,i) = A(i,i);
    U(i, i+1:n) = A(i, i+1:n);
    L(i, 1:i-1) = A(i, 1:i-1);
    sprintf('row %d of L,U,D are built', i)
end

% verify convergence with spectral radius of T

T = - inv(D) * (L+U);
disp('T calculated');

%{
max_lambda = max(eig(T));
sprintf(' Spectral radius = %d', max_lambda')
if max_lambda < 1
    disp('Jacobi will converge');
end
%}