function [y,T_x0, T,b,t_elapse] = T_dist_steady(x_elem,y_elem)
%T_DIST_STEADY Summary of this function goes here
%   Detailed explanation goes here

%% setup

%start timer
tic 

% Constants
global T_b rho C_p k_a h_a T_inf C K cc

delta_x = 1 /(x_elem - 1); % in cm
delta_y = 2 /(y_elem - 1); % in cm

% create A matrix 
A = zeros(x_elem * y_elem);

%% note! 'index' is used as the central T node. 

%% Bottom nodes fill the first x_elem rows

% g function (x input in meters)
g = @(x) 1.05 * x * (1- x);
for index = 1:x_elem  
    A(index,index) = 1;
    b(index,1) = T_inf + g(delta_x * (index-1)) * (T_b - T_inf);
end
 row_counter = index+1;

%% middle nodes 

%iterate row by row
for j = 2:(y_elem - 1) % pull out each interior row (starting at 2nd bottom)
    for i = 2: (x_elem - 1) % pull out each node in the row
        
        % Create indices
        index = x_elem * (j-1) + i; % central index
        left_i = index - 1;
        right_i = index + 1;
        lower_i = index - x_elem;
        upper_i = index + x_elem;
        
        % Update coefficint values (b = 0 for all) ----------------
        A(index,index) = - 2 * ( (1/delta_x)^2 + (1/delta_y)^2 );
        A(index,left_i) =  (1/delta_x)^2;
        A(index,right_i) = (1/delta_x)^2;
        A(index,lower_i) =  (1/delta_y)^2;
        A(index,upper_i) =   (1/delta_y)^2;
        % ----------------------------------------
        
        row_counter = row_counter + 1;   
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
    % RHS values
    b(index, 1) =  T_inf;
    
    % -----------------------
    row_counter = row_counter + 1;
end 
%% left nodes
for index = (x_elem + 1): x_elem:( x_elem * (y_elem-2)+1)
    % Create indices
    right_i = index + 1;
    
    % Update values ---------
    % coefficients
    A(index,right_i) = - C / delta_x;  
    A(index,index) =  1 + ( C /delta_x );
    % RHS values
    b(index, 1) =  T_inf;
    
    % -----------------------
    row_counter = row_counter + 1;
end 

%% Top nodes

for index = (x_elem * (y_elem - 1) + 1) : (x_elem * y_elem)
    % Create indices
    lower_i = index - x_elem;
    
    % Update values ---------
    % coefficients
    A(index,lower_i) =   - C / delta_y; 
    A(index,index) =  1 + ( C/delta_y );
    % RHS values
    b(index, 1) =  T_inf;
    
    % -----------------------
    row_counter = row_counter + 1;
end 

%% Assign variables 
T = A;
sprintf('A and b matrices made(%d)', cc+1')

%% Proven solution 
%[L,U] = lu(T);
%size (L)
%size(b)
%y=L\b;
%size(U)
%size(y)
% T_map= U\y;

 % T_map=T\b;

%% Troubleshoot Solution

%[L,U] = LU_fact(T);
[L,U] = LU(T);
sprintf('L and U made (%d)', cc+1) 
y = ForwardSub (L,b);
sprintf('foward sub done (%d)', cc+1')
T_map = BackwardSub(U,y);
sprintf('backward sub done (%d)', cc+1')
t_elapse = toc;
T = T_map;
%%
%{
for row = 1:y_elem
    for col = 1:x_elem
        index = x_elem * (row-1) + col;
        soln((y_elem-row+1),col) = T_map(index);
    end 
end 
%}

T_plot(cc,T_map,x_elem,y_elem)

cc = cc+1;

r = 1;
y = [0:delta_y:2];
for i = 1:x_elem:(x_elem*(y_elem - 1)+ 1)
T_x0(r) = T(i);
r = r+1;

end

