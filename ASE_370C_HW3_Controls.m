%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ASE 370C: Feedback Control Systems
% HOMEWORK 3 MAIN FILE
close all; format long g; clc;% clear all;
set(0, 'DefaultAxesFontSize',18, 'DefaultLineLineWidth',2,...
    'DefaultLineMarkerSize',4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Problem 1 Part (a)
% System 1
s1.a = -1; s1.b = 1; s1.c = 1; s1.d = 0;
% System 2
s2.a = -10; s2.b = 10; s2.c = 1; s2.d = 0;

% Frequency Range
omega_range = [0 0.1 1 10];

% System 1 for-loop
for ii = 1:length(omega_range)
    
    [Gw1_mag(ii,1),ang_Gw1(ii,1)] = calc_Gw_mag(omega_range(ii),s1);
    
end%for

% System 2 for-loop
for ii = 1:length(omega_range)
    
    [Gw2_mag(ii,1),ang_Gw2(ii,1)] = calc_Gw_mag(omega_range(ii),s2);
    
end%for

% Outputting answers to problem 1a
Gw1_mag
ang_Gw1
Gw2_mag
ang_Gw2

%% Problem 1 Part (c)

sys1 = ss(s1.a, s1.b, s1.c, s1.d);
sys2 = ss(s2.a, s2.b, s2.c, s2.d);

% Given IC for all cases
x0 = 0;

% Case (i) & (ii)
t_i = linspace(0,8,200);
u_i = ones(length(t_i),1);
y_i = lsim(sys1,u_i,t_i,x0);
y_ii = lsim(sys2,u_i,t_i,x0);

figure
hold on
plot(t_i,y_i)
plot(t_i,y_ii)
plot(t_i,u_i)
grid on
title('Response over Time for Given First-Order Linear System w/ Input u(t)')
xlabel('Time (s)')
ylabel('Response')
legend('System 1','System 2','u(t) = 1')
hold off

% Case (iii) & (iv)
t_iii = linspace(0,100,200);
u_iii = sin(0.1 * t_iii);
y_iii = lsim(sys1,u_iii,t_iii,x0);
y_iv = lsim(sys2,u_iii,t_iii,x0);

figure
hold on
plot(t_iii,y_iii)
plot(t_iii,y_iv)
plot(t_iii,u_iii)
grid on
title('Response over Time for Given First-Order Linear System w/ Input u(t)')
xlabel('Time (s)')
ylabel('Response')
legend('System 1','System 2','u(t) = sin(0.1*t)')
hold off

% Case (v) & (vi)
t_v = linspace(0,20,200);
u_v = sin(t_v);
y_v = lsim(sys1,u_v,t_v,x0);
y_vi = lsim(sys2,u_v,t_v,x0);

figure
hold on
plot(t_v,y_v)
plot(t_v,y_vi)
plot(t_v,u_v)
grid on
title('Response over Time for Given First-Order Linear System w/ Input u(t)')
xlabel('Time (s)')
ylabel('Response')
legend('System 1','System 2','u(t) = sin(t)')
hold off

% Case (vii) & (viii)
t_vii = linspace(0,2,200);
u_vii = sin(10*t_vii);
y_vii = lsim(sys1,u_vii,t_vii,x0);
y_viii = lsim(sys2,u_vii,t_vii,x0);

figure
hold on
plot(t_vii,y_vii)
plot(t_vii,y_viii)
plot(t_vii,u_vii)
grid on
title('Response over Time for Given First-Order Linear System w/ Input u(t)')
xlabel('Time (s)')
ylabel('Response')
legend('System 1','System 2','u(t) = sin(10*t)')
hold off





