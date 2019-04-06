function [L,U,P] = LU_pivot(A) % declaration of function 
% L, U, and P are output of the program
% A is the input matrix or argument to the function 

[n,n] = size(A); % checking the size of matrix
L=eye(n); P=L; U=A; % assigning process

for k=1:n %start of loop
    [pivot m]=max(abs(U(k:n,k))); % pivoting process
    m=m+k-1;
    if m~=k % begining of scope of if statement 
        % interchange rows m and k in U
        temp=U(k,:); % assigning to temporary variable
        U(k,:)=U(m,:);
        U(m,:)=temp; % returnig the value from temp
        
        % interchange rows m and k in P
        %temp=P(k,:); % assigning to temp 
        %P(k,:)=P(m,:);
        %P(m,:)=temp; % returning the value from temp
        
        if k >= 2 % checking the condition using if
            temp=L(k,1:k-1);
            L(k,1:k-1)=L(m,1:k-1);
            L(m,1:k-1)=temp;
        end % end of if scope
    end
    for j=k+1:n  % loop to print output 
        L(j,k)=U(j,k)/U(k,k);
        U(j,:)=U(j,:)-L(j,k)*U(k,:);
    end
end
