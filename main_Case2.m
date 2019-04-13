
close all
clear all
clc

clocktimer = tic; 
t = 4;

% Constants
T_b = 420;                   % [Kelvin]
rho = 8960;                  % [kg/m^3]
C_p = 0.39;                  % [Kj/kg.K]
k_a = 380.42;                % [W/(m.K)]
h_a = 6;                     % [W/(m^2.K)] 
T_inf = 370;                 % [Kelvin]
alpha = k_a/(C_p * rho);     % [m^2/s]

% Size of grid 
width = 3;
height = 5;
delta = 1/(width-1);      %[m]
delta_hk = h_a*delta/k_a;

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

% Populate matrices
C (1,1) = alpha/delta^2 *(2/(1 + delta_hk)-4);
C (1,2) = (alpha/delta^2);
C (1,3) = 0;

C (2,1) = (alpha/delta^2);
C (2,2) = alpha/delta^2 *(2/(1 + delta_hk)-4);
C (2,3) = (alpha/delta^2);

C (3,1) = 0;
C (3,2) = (alpha/delta^2);
C (3,3) = alpha/delta^2 *(3/(1 + delta_hk)-4);

r (1,1) = (alpha/delta^2)*((T_inf/(1+delta_hk^(-1)))+T2);
r (2,1) = (alpha/delta^2)*((T_inf/(1+delta_hk^(-1))));
r (3,1) = (alpha/delta^2)*((T_inf/(1+delta_hk^(-1))))*3;

% Utilize deflation method to obtain P and D
timer1 = tic;
[P,D] = deflation(C)
toc (timer1)

timer2 = tic;
[Pstrd,Dstrd] = eig(C)                  % Verification with matlab function
toc (timer2)

% Find solution for given time step  
exp_Dt = matexp (t.*D);

T_int = P * exp_Dt * inv(P) * (T_0+inv(C)*r) - inv(C) * r;
T_14 = T_int(3,1)/(1+delta_hk)+T_inf/(1+k_a/h_a/delta);

T_dist = zeros (5,3);

% Populate centre nodes
T_dist (1,2) = T_14;
T_dist (2,2) = T_int (3,1);
T_dist (3,2) = T_int (2,1);
T_dist (4,2) = T_int (1,1);

% Populate bottom nodes
for i = 1:3
    T_dist (5,i) = T_nodesbot(i);
end

% Populate side nodes
for i = 1:4
    T_dist(i,1) = T_dist (i,2) * 1/(delta_hk+1) + T_inf /(1+delta_hk^(-1));
    T_dist (i,3) = T_dist (i,1);
end

T_dist
toc(clocktimer)

h = heatmap (T_dist, 'Colorlimits', [370,420]);
h.Colormap = jet;

