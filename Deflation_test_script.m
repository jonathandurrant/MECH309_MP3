
% Preliminary
C = randi(2,6,6);
% C =[2 1 1; 1 4 2; 1 1 2];

[P,D] = deflation_new (C);

Matlab_eigenvalues = eig(C) % Verify with Matlab function


