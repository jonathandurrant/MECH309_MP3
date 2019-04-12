close all
clear all
clc

% Constants
T_b = 420;                   % [Kelvin]
rho = 8960;                  % [kg/m^3]
C_p = 0.39;                  % [Kj/kg.K]
k_a = 380.42;                % [W/(m.K)]
h_a = 6;                     % [W/(m^2.K)] 
T_inf = 370;                 % [Kelvin]
alpha = k_a/(C_p * rho);     

% Size of grid
width = 3;
height = 5;
delta = 1/(width-1);      %[m]

% Number of interior nodes
int_nodes = width*height - 2*width - 2*(height-2);

% Matrices
C = zeros(3,3);
r = zeros (3,1);
T_0 = zeros (3,1);

% Initialize temperature
T_0 (:,1) = T_inf;           

T_bot = @(x) 370 + 50.*1.05.*x.*(1.-x);
x_bot = linspace(0,1,width);
T_nodesbot = T_bot(x_bot);
T2 = T_nodesbot(2);

% Components
deltahk = h_a*delta/k_a;

F = alpha/(delta^2);
H = F * (3/(1+deltahk)-4);


G = F * (T_inf/(1+(deltahk^-1)));
K = F * (-4 + (3*T_inf)/(deltahk+1));

% Populate matrices
C (1,1) = alpha/delta^2 *(2/(1 + deltahk)-4);
C (1,2) = (alpha/delta^2);
C (1,3) = 0;

C (2,1) = (alpha/delta^2);
C (2,2) = alpha/delta^2 *(2/(1 + deltahk)-4);
C (2,3) = (alpha/delta^2);

C (3,1) = 0;
C (3,2) = (alpha/delta^2);
C (3,3) = alpha/delta^2 *(3/(1 + deltahk)-4);

r (1,1) = (alpha/delta^2)*((2*deltahk*370/(1+deltahk))+T2);
r (2,1) = (alpha/delta^2)*((2*deltahk*370/(1+deltahk)));
r (3,1) = (alpha/delta^2)*(3*deltahk/(1+deltahk))*370;

% Utilize deflation method to obtain P and D
[P,D] = deflation(C)
eig(C)

% Find solution for every time step over 

t = 2;
exp_Dt = matexp (t.*D);
T_t_int = P * exp_Dt * inv(P) * (T_0+inv(C)*r) - inv(C) * r
