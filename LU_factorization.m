function [L,U] = LU_facotrization(A)

n = size(A,1); % the number of rows or columns, A is a square matrix n by n

% initialize L and U
L = eye(n); % n by n identity matrix
U = A;

for k = 1:n-1; % k is basically the number operation required to obtain zero's below the diagonal
    for lv1 = k+1:n; % each row of matrix U after the kth row
        m(lv1,k) = -U(lv1,k)/U(k,k); % m is the constant used in row operation to get the lower part of the matrix to be zero
        for j = k:n %where j represents the columnn 
            U(lv1,j) = U(lv1,j) + m(lv1,k)*U(k,j);
        end
        L(lv1,k) = -m(lv1,k); % L matrix stores the constants used in each row-operation
    end
end
L
U
     