
% Preliminary
%A = randi(10,5,5);
%x = randi(5,5,1);
A =[2 1 1 1; 1 4 2 2; 1 1 2 3; 1 2 4 5];
n = size(A,1);
x = randi(5,n,1);

% Initialize deflation

epsilon = (10^(-12));
[lambda1, v1, mu] = power_method(A, x, epsilon);
[D,P] = deflation(A, lambda1, v1, epsilon);

eig(A) % Verify with Matlab function


