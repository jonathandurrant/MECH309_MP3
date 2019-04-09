function [C,r] = Transient_case2_createC(x_elem,y_elem)
%TRANSIENT_CASE2_CREATEC Summary of this function goes here
%   Detailed explanation goes here

%% Constants
global T_b rho C_p k_a h_a T_inf C K
delta_x = 1 /(x_elem - 1); % in cm
delta_y = 2 /(y_elem - 1); % in cm
 
% create A matrix 
C = zeros(x_elem * y_elem);
r = zeros(x_elem * y_elem,1);

%% middle nodes 

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
        C(index,index) = K * (- 2 * ( (1/delta_x)^2 + (1/delta_y)^2 )) ;
        C(index,left_i) = K * ( (1/delta_x)^2) ;
        C(index,right_i) = K * ((1/delta_x)^2) ;
        C(index,lower_i) = K * ( (1/delta_y)^2) ;
        C(index,upper_i) =  K * ( (1/delta_y)^2) ;
        % ----------------------------------------
          
    end
end

C

end

