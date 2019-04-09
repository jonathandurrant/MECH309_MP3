
% Preliminary
% C = randi(10,3,3);
C =[2 1 1; 1 4 2; 1 1 2];
%n = size(A,1);
%x = randi(5,n,1);


[P,D] = deflation_new (C);

Matlab_eigenvalues = eig(C) % Verify with Matlab function


