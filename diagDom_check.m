function [answ] = diagDom_check(A)
%DIAGDOM_CHECK Summary of this function goes here
%   Detailed explanation goes here
answ =  'yes';

% convert all entries to Abs value
A = abs(A);

for i = 1:length(A)     % for each row
    x = sum(A(i,:));        % sum entire row
    if x > A(i,i)            % if row contains elements other than diag
        x = x - A(i,i);
    end
    
    if A(i,i) <= x
        sprintf('%d row is NOT diagonally dominant', i)
        sprintf('x = %d a_ii = %d',x)
        sprintf('a_ii = %d',A(i,i))
        answ = 'No';
    end
end


end

