function [P,D] = deflation_new(C)

%% Preliminary
epsilon = 10E-8;   %Stopping criteria
n = size(C,1);
x = randi(5,n,1);   % Arbitrary input vector

%% Initialize
[lambda1, v1, mu] = power_method(C, x, epsilon);

B1 = C;
u1 = v1;
n = size (C,1);
x = randi (5,n,1);

P = zeros (n);
D = zeros (n);

P(:,1) = v1;
D(1,1) = lambda1;

%% Deflation loop
for i = 1:(n-1)
    B2 = B1 - lambda1 * u1 * transpose(u1);
    [lambda2, u2, mu] = power_method (B2, u1, epsilon);     %u2 not exactly equal to v2, must use Inverse Power w/ Shift
    [lambda2pr, v2] = power_inv_shift (C, u2, mu, epsilon); %new value of lambda might be different, must verify
    
    if abs(lambda2pr - lambda2)>10^(-1)
        disp ('Error. Choose smaller epsilon');
        break  
    end
    
    B1 = B2;
    u1 = u2;
    lambda1 = lambda2;
    
    D(i+1,i+1) = lambda2;   % Populate diagonal of D
    P(:,i+1) = v2;          % Populate eigenvector matrix P
    
    i = i+1;
end


end

