%% MECH 309 Mini-Project 3
% Jonathan Durrant 
% Gregoire Carlesimo

close all
clear all
clc

% Format of output
% format short
% format long

%% Finite difference approximations 



%% Steady state analysis

% Create empty matrices for each grid-size

x_elem = [6,16,46,61];
y_elem = [11,31,91,121];

% Temperature distributions 

[A1, b1, t_elapse(1)] = T_dist_steady(x_elem(1),y_elem(1));
%[A2, b2, t_elapse(2)] = T_dist_steady(x_elem(2),y_elem(2));
%[A3, b3, t_elapse(3)] = T_dist_steady(x_elem(3),y_elem(3));
%[A4, b4, t_elapse(4)] = T_dist_steady(x_elem(4),y_elem(4));

T1 = A1\b1;
%T2 = A2\b2;
%T3 = A3\b3;
%T4 = A4\b4;

hold on
plot (1:length(b1),T1)
%plot (1:length(b2),T2)
%plot (1:length(b3),T3)
%plot (1:length(b4),T4)
hold off




