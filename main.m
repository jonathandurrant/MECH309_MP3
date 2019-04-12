%% MECH 309 Mini-Project 3
% Jonathan Durrant 
% Gregoire Carlesimo

close all
clear all
clc

% Format of output
% format short
% format long

% global variables 
global T_b rho C_p k_a h_a T_inf C K cc


T_b = 420;      % Kelvin
rho = 8960;     %kg/m^3
C_p = 0.39;     % Kj/kg.K
k_a = 380.42; % W/(m.K) 
h_a = 6; % W/(m^2.K) 
T_inf = 370; % Kelvin
C = (k_a / h_a) / 100;      % cm
K = (k_a / ( rho * C_p)) * (100^2 / 1000);   % cm^2/s
cc=0;   % to track case for plots

%% Finite difference approximations 



%% Steady state analysis

% Create empty matrices for each grid-size

x_elem = [6,16,46,61];
y_elem = [11,31,91,121];

% Temperature distributions 

[y_1,T_x0_1,T1, b1, t_elapse(1)] = T_dist_steady_trial(x_elem(1),y_elem(1));
[y_2,T_x0_2,T2, b2, t_elapse(2)] = T_dist_steady_trial(x_elem(2),y_elem(2));
[y_3,T_x0_3, T3, b3, t_elapse(3)] = T_dist_steady_trial(x_elem(3),y_elem(3));
[y_4,T_x0_4, T4, b4, t_elapse(4)] = T_dist_steady_trial(x_elem(4),y_elem(4));

% plot x=o and error 
%plot_x0(y_elem, T1, T2, T3, T4)
subplot (3,3,7)
hold on
plot(y_1,T_x0_1) 
plot(y_2,T_x0_2)
plot(y_3,T_x0_3)
plot(y_4,T_x0_4)
xlabel('Y-position (cm)');
ylabel('Temp (K)');
title('Temp Plot on x=0');
legend('66 elems', '496 elems', '4186 elems', '7381 elems');
num_elem = [6*11, 16*31, 46*91,  61*121];
subplot(3,3,6)


%% Transient case 1

%{
%assign time step and grid 
h = 10^-4;  %sec
x = 16;
y = 31;
t_stop = 1; % sec

% initialize A matrix and produce L and U Matrices for xXy grid
tic 
[L,U,b] = transient_1_init(x,y);
%Solve for t=0 
T_map_init(1:x*y,1) = 370; % Initialize T of each node to T_inf
% add bottom boundary initial conditions
T_map_init(1:x, 1) = b(1:x,1);
T_i = T_map_init;
T_plot(0,T_i,x,y)

% iterate over time
for i = h:h:t_stop
    [T_i,t_elapse] = T_dist_transient_1(T_i,i,x,y,h,L,U,b);
end 
toc 
T_i
num_elem = [6*11];%, 16*31 46*91]; % 61*121];
plot(num_elem, t_elapse);

%% Trnsient Analysis - CASE 2












%}

