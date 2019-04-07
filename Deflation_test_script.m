
% Preliminary
%A = randi(10,5,5);
%x = randi(5,5,1);
A =[2 1 1; 1 4 2; 1 1 2];
x = randi(5,3,1);

% Initialize deflation

stopcrit = (10^(-6));
[lambda1, v1, mu] = power_method(A, x, 10^(-6));
[D,P] = deflation(A, lambda1, v1, 10^(-6));



