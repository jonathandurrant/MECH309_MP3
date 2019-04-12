function t_elapse = T_plot(Case,T,x,y)
%T_PLOT Summary of this function goes here
%   Detailed explanation goes here

tic 
for row = 1:y
    for col = 1:x
        index = x * (row-1) + col;
        soln((y-row+1),col) = T(index);
    end 
end 

switch Case
    case 0 
        subplot(3,2,1)
    case 1
        subplot(3,2,2)
    case 2
        subplot(3,2,3)
    case 3
        subplot(3,2,4)
    case 4
        subplot(3,2,5)
    case 5
        subplot(3,2,6)
    case 6
        subplot(3,3,7)
    case 7
        subplot(3,3,8)
     case 8
        subplot(3,3,9)
    otherwise
        disp("error");  
end 

h = heatmap(soln);
h.Colormap = jet;
time_elapse = toc;
end

