function [L,U,b_mod] = LU_fact(A,b)

n = size(A,1); % the number of rows or columns, A is a square matrix n by n

% initialize L and U
L = eye(n); % n by n identity matrix
U = A;
b_mod = b; 


for j = 1:n-1 % row index 
    for row_index = j+1:n % each row of matrix U after the kth row
        
        
        m(row_index,j) = -U(row_index,j)/U(j,j); % m is the constant used in row operation to get the lower part of the matrix to be zero
        for i = j:n %where j represents the columnn 
            U(row_index,i) = U(row_index,i) + m(row_index,j)*U(j,i);
        end
        L(row_index,j) = -m(row_index,j); % L matrix stores the constants used in each row-operation
    end
end

     