
% Preliminary
%C = randi(2,4,4);
 C =[2 1 1; 1 4 2; 1 1 2];

[P,D] = deflation_new (C);

Matlab_eigenvalues = eig(C) % Verify with Matlab function


