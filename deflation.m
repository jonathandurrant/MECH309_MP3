function [D,P] = deflation(A, lambda1, v1, stopcrit)

% Initialize
B1 = A;
u1 = v1;
n = size (A);
D = zeros (n),
D(1,1) = lambda1;
P = zeros (n),
P(:,1) = v1;

% Deflation loop
for i = 1:(n-1)
    B2 = B1 - lambda1 * u1 * transpose(u1);
    [lambda2, u2, mu] = power_method (B2, u1);  %u2 not exactly equal to v2, must use Inverse Power w/ Shift
    [lambda2pr, v2] = power_inv_shift (A, u2, mu); %new value of lambda might be different, must verify
    
    if abs(lambda2pr - lambda2)>10^(-6)
        disp ('Error. Choose smaller epsilon');
        break  
    end
    
    D(i+1,i+1) = lambda2; % Populate diagonal of D
    P(:,i+1) = v2; % Populate eigenvector matrix
    
    i = i+1;
end

D
P

end

