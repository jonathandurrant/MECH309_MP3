function x = plot_x_0(x_elem,y_elem, T)

x = 0; 
% Constants
delta_x = 1 /(x_elem - 1); % in cm
delta_y = 2 /(y_elem - 1); % in cm

% create y matrix 
y = [0:delta_y:2];

% create T matrix 
r = 1;
for i = 1:x_elem:(x_elem*(y_elem - 1)+ 1)
T_x0(r) = T(i);
r = r+1;
end 
length(T_x0)
length(y)
name = sprintf(' %d Element Grid', x_elem * y_elem);


plot(y, T_x0);
legend(name);
hold on


