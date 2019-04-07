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

[A1, b1, t_elapse(1)] = T_dist_steady_trial(x_elem(1),y_elem(1));
%[A2, b2, t_elapse(2)] = T_dist_steady_trial(x_elem(2),y_elem(2));
%[A3, b3, t_elapse(3)] = T_dist_steady_trial(x_elem(3),y_elem(3));
%[A4, b4, t_elapse(4)] = T_dist_steady_trial(x_elem(4),y_elem(4));

t_elapse;
num_elem = [6*11];%, 16*31 46*91]; % 61*121];
plot(num_elem, t_elapse);

%% Trnsient Analysis - CASE 2
% Need to formulate problem s.t. T_dot = CT + r
% Then C = PDinv(P)
% Finally T(t) = P exp.....

% Find D and P for a 3x5 grid
%C = A1;
%epsilon = 10^(-7);
%n = size(C,1);
%x = randi(5,n,1);
%epsilon = (10^(-12));
%[lambda1, v1, mu] = power_method(C, x, epsilon);
%[D,P] = deflation(C, lambda1, v1, epsilon);

%ED = matexp (t.*D);
%T(t) = P*ED*inv(P)*(T_0+inv(C)*r)-inv(C)*r;


