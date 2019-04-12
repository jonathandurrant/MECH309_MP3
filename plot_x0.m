function [outputArg1,outputArg2] = plot_x0(y_elem, T1, T2, T3, T4)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = 0;
outputArg2 = 0;

subplot(3,2,5)
hold on

% y values  
xlabel('Position on the y-axis (cm)');
x1 = 0:2/y_elem(1):2;
x2 = 0:2/y_elem(2):2;
x3 = 0:2/y_elem(3):2;
x4 = 0:2/y_elem(4):2;

%T1
for i = 1:y_elem(1):length(T1)
    y1(i) = T1(i); 
end 
plot(x1,y1);

%T2
for i = 1:y_elem(2):length(T2)
    y2(i) = T2(i); 
end 
plot(x2,y2);

%T3
for i = 1:y_elem(3):length(T3)
    y3(i) = T3(i); 
end 
plot(x3,y3);

%T4
for i = 1:y_elem(4):length(T4)
    y4(i) = T4(i); 
end 
plot(x4,y4);

hold off

end

