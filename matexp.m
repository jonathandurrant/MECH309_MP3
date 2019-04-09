function [expo] = matexp(D)

n = size (D,1);
expo = zeros(n);

for i = 1:n
    expo(i,i) = exp(D(i,i));
end

end

