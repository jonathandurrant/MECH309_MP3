function [T,b,t_elapse] = T_dist_steady(x_elem,y_elem)
%T_DIST_STEADY Summary of this function goes here
%   Detailed explanation goes here

%% setup

%start timer
tic 

% Constants
delta_x = 0.01/(x_elem-1); % in m
delta_y = 0.02/(y_elem-1); % in m
k_a = 380.42; % W/(m.K)
h_a = 10; % W/(m^2.K) 
T_inf = 370; % Kelvin
C = k_a / h_a;      % m
T_b = 420;      % Kelvin

% create A matrix 
A = zeros(x_elem * y_elem);

%% note! 'index' is used as the central T node. 

%% Bottom nodes fill the first x_elem rows

% g function 
g = @(x) 1.05 * x * (1-x);
for index = 1:x_elem  
    A(index,index) = 1;
    b(index,1) = T_inf + g(delta_x * (index-1) * 100) * (T_b - T_inf);
end
 row_counter = index+1;

%% middle nodes 

%iterate row by row
for j = 2:(y_elem - 1) % pull out each interior row (starting at bottom)
    for i = 2: (x_elem - 1) % pull out each node in the row
        
        % Create indices
        index = x_elem * (j-1) + i; % central index
        left_i = index - 1;
        right_i = index + 1;
        lower_i = index - x_elem;
        upper_i = index + x_elem;
        
        % Update coefficint values (b = 0 for all) ----------------
        A(row_counter,index) = - 2 * ( (1/delta_x)^2 + (1/delta_y)^2 );
        A(row_counter,left_i) =  (1/delta_x)^2;
        A(row_counter,right_i) = (1/delta_x)^2;
        A(row_counter,lower_i) =  (1/delta_y)^2;
        A(row_counter,upper_i) =   (1/delta_y)^2;
        % ----------------------------------------
        
        row_counter = row_counter + 1;   
    end
end
        
%% Right nodes 

for index = (x_elem * 2): x_elem:( x_elem * (y_elem))
    % Create indices
    left_i = index - 1;
    lower_i = index - x_elem;
        
    
    % Update values ---------
    % coefficients
    
    A(row_counter,left_i) =  C / delta_x; 
    A(row_counter,index) =  1 - ( C /delta_x );
    % RHS values
    b(row_counter, 1) =  T_inf;
    
    % -----------------------
    row_counter = row_counter + 1;
end 
%% left nodes
for index = (x_elem + 1): x_elem:( x_elem * (y_elem-2)+1)
    % Create indices
    right_i = index + 1;
    upper_i = index + x_elem;
    
    % Update values ---------
    % coefficients
    A(row_counter,right_i) =  - k_a / ( h_a* delta_x);  
    A(row_counter, upper_i) = - k_a / ( h_a* delta_y); 
    A(row_counter,index) =  1 + C * ( 1/(delta_x) + 1/(delta_y) );
    % RHS values
    b(row_counter, 1) =  T_inf;
    
    % -----------------------
    row_counter = row_counter + 1;
end 

%% Top nodes

for index = (x_elem * (y_elem - 1) + 2) : (x_elem * y_elem)
    % Create indices
    lower_i = index - x_elem;
    left_i = index - 1;
    
    % Update values ---------
    % coefficients
    A(row_counter,lower_i) =  - k_a / ( h_a* delta_y); 
    A(row_counter,left_i) =  - k_a / ( h_a* delta_x); 
    A(row_counter,index) =  1 +  C * ( 1/(delta_x) + 1/(delta_y) );
    % RHS values
    b(row_counter, 1) =  T_inf;
    
    % -----------------------
    row_counter = row_counter + 1;
end 

%% Assign variables 
T = A;
t_elapse = toc;

size(A)
size(b)

%% Proven solution 
%[L,U] = lu(T);
%size (L)
%size(b)
%y=L\b;
%size(U)
%size(y)
%T_map= U\y;

%% Troubleshoot Solution
%[L,U] = LU_pivot (T),
[L,U] = LU_factorization (T);
y = ForwardSub (L,b);
T_map = BackwardSub(U,y);

%%
for row = 1:y_elem
    for col = 1:x_elem
        index = x_elem * (row-1) + col;
        soln((y_elem-row+1),col) = T_map(index);
    end 
end 

h = heatmap(soln);
h.Colormap = jet;

end

