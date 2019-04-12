function [exp_Dt] = matexp(D)

n = size (D,1);
exp_Dt = zeros(n);

for i = 1:n
    exp_Dt(i,i) = exp(D(i,i));
end

end

