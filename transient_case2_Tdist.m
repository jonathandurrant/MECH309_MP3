function T_dist = transient_case2_Tdist(x_elem, y_elem, T_int)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% Initialiize

global T_b rho C_p k_a h_a T_inf C K

% Constants
delta_x = 1 /(x_elem - 1); % in cm
delta_y = 2 /(y_elem - 1); % in cm


%% Bottom nodes fill the first x_elem rows

% g function (x input in meters)
    
g = @(x) 1.05 * x * (1- x);
for index = 1:x_elem  
    T(index,1) = T_inf + g(delta_x * (index-1), t_i) * (T_b - T_inf);
end

%% Middle nodes

int_node = 1;       % keep track of which node to extract from T_int
for j = 2:(y_elem - 1) % pull out each interior row (starting at 2nd bottom)
    for i = 2: (x_elem - 1) % pull out each node in the row
        
        % Create indices
        index = x_elem * (j-1) + i; % central index
        T(index,1) = T_int(int_node);
        int_node  = int_node + 1;
    end

%% Right nodes 

for i = x_elem * 2:x_elem:x_elem*y_elem
    T(i,1) = 1; % -------------------------------------------------
end 
%% Left nodes 
 for i = x_elem:x_elem: x_elem * (y_elem-1) + 1;
     T(i,1) = 1; % -------------------------------------------------
 end 
 
 %% Top nodes 
 
 for i = (x_elem * (y_elem - 1) + 2) : 1: x_elem*y_elem
     T(i,1) = 1; % -------------------------------------------------
 end 
 
 T_dist = T; 
 
 for row = 1:y_elem
    for col = 1:x_elem
        index = x_elem * (row-1) + col;
        soln((y_elem-row+1),col) = T_dist(index);
    end 
 end
 
h = heatmap(soln);
h.Colormap = jet;
