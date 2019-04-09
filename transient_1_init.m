function [L,U,b] = transient_1_init(x_elem,y_elem)
%TRANSIENT_1_INIT Summary of this function goes here
%   Detailed explanation goes here

%% Constants
global T_b rho C_p k_a h_a T_inf C K
delta_x = 1 /(x_elem - 1); % in cm
delta_y = 2 /(y_elem - 1); % in cm
 
% create A matrix 
A = zeros(x_elem * y_elem);

%% Bottom nodes fill the first x_elem rows
phi = @(t) 1 + ( 0.05*sin( 10*pi()*t ) );
g = @(x, t) 1.05 * x * (1- x) * phi(t);

for index = 1:x_elem  
    A(index,index) = 1;
    b(index,1) = T_inf + g(delta_x * (index-1), 0) * (T_b - T_inf);    
end
 
%% middle nodes 

%iterate row by row
for j = 2:(y_elem - 1) % pull out each interior row (starting at 2nd bottom)
    for i = 2: (x_elem - 1) % pull out each node in the row
        % Create indices
        index = x_elem * (j-1) + i; % central index
        
        % Update coefficint 
        A(index,index) = 1;
        
        
    end
end

%% Right nodes 

for index = (x_elem * 2): x_elem:( x_elem * (y_elem -1))
    % Create indices
    left_i = index - 1;
        
    % Update values ---------
    % coefficients
    
    A(index,left_i) = - C / delta_x; 
    A(index,index) =  1 + ( C / delta_x );
    b(index, 1) =  T_inf;
    
    % -----------------------
end 
%% left nodes
for index = (x_elem + 1): x_elem:( x_elem * (y_elem-2)+1)
    % Create indices
    right_i = index + 1;
    
    % Update values ---------
    % coefficients
    A(index,right_i) = - C / delta_x;  
    A(index,index) =  1 + ( C /delta_x );
    b(index, 1) =  T_inf;
    % -----------------------
end 

%% Top nodes

for index = (x_elem * (y_elem - 1) + 1) : (x_elem * y_elem)
    % Create indices
    lower_i = index - x_elem;
    
    % Update values ---------
    % coefficients
    A(index,lower_i) =   - C / delta_y; 
    A(index,index) =  1 + ( C/delta_y );
    b(index, 1) =  T_inf;
       
    % -----------------------
end

[L,U] = LU_fact(A);



end

