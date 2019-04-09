function [T_next,t_elapse] = T_dist_transient_1(T_i,t_i,x_elem,y_elem,h,L,U,b)
%T_DIST_TRANSIENT Solves the T_distribution for an inputted given time -> T_dist for next time step. 
%   Detailed explanation goes here


%% setup
global T_b rho C_p k_a h_a T_inf C K

%start timer
tic 

% Constants
delta_x = 1 /(x_elem - 1); % in cm
delta_y = 2 /(y_elem - 1); % in cm


%% note! 'index' is used as the central T node. 

%% Bottom nodes fill the first x_elem rows

% g function (x input in meters)
if t_i < 2
    phi = @(t) 1 + ( 0.05*sin( 10*pi()*t ) ); 
else 
    phi = @(t) ( 0.05*exp( -0.5*(t - 2)) ) +0.95;
end

g = @(x, t) 1.05 * x * (1- x) * phi(t);
for index = 1:x_elem  
    b(index,1) = T_inf + g(delta_x * (index-1), t_i) * (T_b - T_inf);
end

%% middle nodes 

%iterate row by row
for j = 2:(y_elem - 1) % pull out each interior row (starting at 2nd bottom)
    for i = 2: (x_elem - 1) % pull out each node in the row
        
        % Create indices
        % Create indices
        index = x_elem * (j-1) + i; % central index
        left_i = index - 1;
        right_i = index + 1;
        lower_i = index - x_elem;
        upper_i = index + x_elem;
        
        %Pull out past Temperatures 
        T_index = T_i(index,1); % central index
        T_left = T_i(left_i,1);
        T_right = T_i(right_i,1);
        T_lower = T_i(lower_i,1);
        T_upper = T_i(upper_i,1);
        
        % Update b array  ----------------
        b(index,1) = T_index + ( h* K )*( ((T_left - (2 * T_index) + T_right) / (delta_x^2) ) + ((T_lower - (2*T_index) + T_upper)/ (delta_y^2)) ); 
        
        % ----------------------------------------
          
    end
end
        

%% Assign variables 

y = ForwardSub (L,b);
T_next = BackwardSub(U,y);

x = x_elem;
y = y_elem;

cases = [2*10^-4,5*10^-4,10^-3,10^-2,1,2,3,4];
switch t_i
    case cases(1)
        t_i
        T_plot(1,T_next,x,y)
    case cases(2)
        T_plot(2,T_next,x,y)
        t_i
    case cases(3)
        T_plot(3,T_next,x,y)
        t_i
    case cases(4)
        T_plot(4,T_next,x,y)
        t_i
    case cases(5)
        T_plot(5,T_next,x,y)
        t_i
    case cases(6)
        T_plot(6,T_next,x,y)
        t_i
    case cases(7)
        T_plot(7,T_next,x,y)
        t_i
    case cases(8)
        T_plot(8,T_next,x,y)
        t_i   
end 

%%
t_elapse = toc;

end

