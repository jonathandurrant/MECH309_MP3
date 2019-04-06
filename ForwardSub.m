function y = ForwardSub (L,b)

% Input Variable
% L is the lower triangular matrix L
% b is the column vector of constants

% output variable
% y, column vector

n = length(b);

y(1,1) = b(1)/L(1,1); % this is the first value of the column vector
for i = 2:n
    y(i,1) = ( b(i) - L(i,1:i-1)* y(1:i-1,1))./L(i,i);
end
