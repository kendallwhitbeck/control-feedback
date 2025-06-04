%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ASE 370C: Feedback Control Systems
% Mini Project MAIN FILE
close all; format short g; clc; %clear all;
set(0, 'DefaultAxesFontSize',14, 'DefaultLineLineWidth',2,...
    'DefaultLineMarkerSize',20)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Givens
m = 4; % kg
J = 0.0475; % kg*m^2/s
c = 0.05; % N*s/m
g = 9.8; % m/s^2
r = 0.25; % m

A = [0 0 1 0;
    0 0 0 1;
    0 -g -c/m 0;
    0 0 0 0];

B = [0; 0; 1/m; r/J];

C = [1 0 0 0];

D = 0;

% Initial Conditions
x0 = zeros(4,1);

%% Problem 1
disp('Problem 1 ==========================================')
[V, T] = eig(A);

eigVals_open = diag(T)

%% Problem 2
disp('Problem 2 ==========================================')

Mp = 0.1; % percent overshoot (=10%)
ts = 10; % settling time (s)

% Define & find: damping ratio, Z; natural frequency, wn
syms Zsym wnsym
Z = double(vpasolve(Mp == exp(-pi*Zsym/sqrt(1-Zsym^2)) ,Zsym));
wn = double(vpasolve(0.01 == exp(-Z*wnsym*ts) ,wnsym));

% Define eigenvalues using Z and wn
eigs = zeros(4,1);
eigs(1) = -Z*wn + wn*sqrt(1-Z^2)*1i;
eigs(2) = -Z*wn - wn*sqrt(1-Z^2)*1i;

% Making faster eigenvalues
f = 5;
eigs(3:4) = f*eigs(1:2)

%% Problem 3
disp('Problem 3 ==========================================')
K = place(A,B,eigs)

%% Problem 4
disp('Problem 4 ==========================================')

% steady-state gain from r to y
G_ry = 1;

syms krsym

% matrix "A" for step input from r to y
A_ry = A - B*K;

% symbolic matrix "B" for step input from r to y
B_ry_sym = krsym*B;

% matrix "C" for step input from r to y
C_ry = C;

% gain from r->y
k_r = double(vpasolve(G_ry == -C_ry / A_ry * B_ry_sym, krsym))

% matrix "B" for step input from r to y
B_ry = k_r*B;


%% Problem 5
disp('Problem 5 ==========================================')

% Defining system from r to y
sys_ry = ss(A_ry,B_ry,C_ry,0);

% Retrieving stepinfo of system from r to y
info_ry = stepinfo(sys_ry,'SettlingTimeThreshold',.01);

% displaying relevant values
fprintf('\nPercent-Overshoot: %.2f%%\n', info_ry.Overshoot)
fprintf('1%% settling time: %.2f seconds\n\n', info_ry.SettlingTime)

%% Problem 8
Apert = A + .02*randn(4,4);
% To Simulink!

%% Problem 10
disp('Problem 10 ==========================================')

% Making a fifth, even fast eigenvalue
eigs(5) = 6*real(eigs(1));
% eigs(5) = 12*real(eigs(1));

% Integral action A & B matrices
A_int = [A zeros(4,1); -C 0];
B_int = [B; 0];
C_int = [C 0];

% Placing integral action matrices to get K_int and k_i
K_int = place(A_int,B_int,eigs);
k_i = K_int(end)
KK = K_int(1:4)

%% Problem 11
disp('Problem 11 ==========================================')

% let k_r be zero for the integral action control
k_r_int = 0;

% r to y, integral action matrices
A_ry_int = A_int - B_int*K_int;
B_ry_int = [B*k_r_int; 1];
C_ry_int = C_int;

% Closed-Loop SS gain from r to y for integral action control
gain_ry_int = -C_ry_int / A_ry_int * B_ry_int

% Defining system from r to y
sys_ry_int = ss(A_ry_int,B_ry_int,C_ry_int,0);

% Retrieving stepinfo of system from r to y
info_ry_int = stepinfo(sys_ry_int,'SettlingTimeThreshold',.01);

% displaying relevant values
fprintf('Percent-Overshoot: %.2f%%\n', info_ry_int.Overshoot)
fprintf('1%% settling time: %.2f seconds\n', info_ry_int.SettlingTime)




