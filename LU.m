function [L,U] = LU(U)

n = size(U,1); % the number of rows or columns, A is a square matrix n by n

for i = 1:n             % For ith LU matrices
    L(i:n,i) = U(i:n,i)./U(i,i);
    for j=i+1:n         % Iterate over rows on ith LU matrices
        U(j,:) = U(j,:) - U(i,:) * U(j,i)./U(i,i);
    end 
end 

    %{

for j = 1:1:n-1 % row index 
    for row_index = j+1:n % each row of matrix U after the kth row
        if mod(j,250) == 0
            sprintf(' LU for %d matrix - loop at i=%d',[n, p])
            p = p + 250;
        end 
        
        m(row_index,j) = -U(row_index,j)/U(j,j); % m is the constant used in row operation to get the lower part of the matrix to be zero
        for i = j:n %where j represents the columnn 
            U(row_index,i) = U(row_index,i) + m(row_index,j)*U(j,i);
        end
        L(row_index,j) = -m(row_index,j); % L matrix stores the constants used in each row-operation
    end
    j
end

    %}
     