function [err_bound,f_dblPrime] = secondOrderFD(f,h,x_0)
%SECONDORDERFD Summary of this function goes here
%   Detailed explanation goes here

f_dblPrime = (f(x_0 - h) - 2*f(x_0)+ f(x_0 - h) ) / h^2; 
err_bound = h^2 / 12;
end

