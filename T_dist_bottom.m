function [T_dist, x_array] = T_dist_bottom(x_nodes, T_b)
%T_DIST_BOTTOM Summary of this function goes here
%   Detailed explanation goes here
delta_x = 1/x_nodes;
g = @(node) T_b * 1.05 * (delta_x * node)  * (1 - delta_x * node); 

for i =0:x_nodes -1
    T_dist(1,i+1) = g(i);
    x_array(1,i+1) = delta_x * i;
end

