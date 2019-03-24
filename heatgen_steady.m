function [x_grid,y_grid,T_dist] = heatgen_steady(x_nodes,y_node)
%Returns a matrix T_dist - the temperature distribution matrix
%   Detailed explanation goes here
x_grid = x_nodes;
y_grid = y_nodes;
T_dist = LU(x_nodes,y_nodes);

end

