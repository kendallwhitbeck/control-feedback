tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ASE 370C: Feedback Control Systems
% Mini Project 3 MAIN FILE
close all; format long g; clc; %clear all;
set(0, 'DefaultAxesFontSize',16, 'DefaultLineLineWidth',1.,...
    'DefaultLineMarkerSize',16)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Problem 5
% givens
r = 0.25; % m
J = 0.0475; % kg*m^2
c = 0.05; % kg/s
m = 1.5; % kg/s
g = 9.8; % m/s^2
l = 0.05; % m
w = linspace(0,2*pi,1000)'; % range of freqs (rad/s)

% gains
ki = 10; % integral gain
% kp = 10; % proportional gain

% TFs
Ps = tf(r,[J c m*g*l]); % plant
C1s = @(kp) tf([kp ki],[1 0]); % PI controller
L1s = @(kp) Ps*C1s(kp); % open loop PI system

% plots
figure
hold on

subplot(1,2,1)
bode(L1s(89),w)
title('Bode Diagram w/ k_p = 89; k_i = 10')
grid on

subplot(1,2,2)
bode(L1s(90),w)
title('Bode Diagram w/ k_p = 90; k_i = 10')
grid on

hold off

[gm1,pm1,~,~] = margin(L1s(90));

%% Problem 8

kp = 90; % proportional gain

% TFs
Cs = @(kd) tf([kd kp ki],[1 0]); % PID controller
Ls = @(kd) Ps*Cs(kd); % open loop PID system

% plots
figure
hold on

subplot(1,2,1)
margin(Ls(2))
% title('Bode Diagram w/ k_d = 10; k_i = 10; k_p = 90')
legend('kd = 2.0')
grid on

subplot(1,2,2)
margin(Ls(2.1))
% title('Bode Diagram w/ k_d = 100; k_i = 10; k_p = 90')
legend('kd = 2.1')
grid on

hold off

%% Problem 9

kd = 2.1; % derivative gain

Cs = tf([kd kp ki],[1 0]); % PID controller
Ls = Ps*Cs; % open loop PID system

L_cl = Ls/(1+Ls); % closed-loop TF

% time range
t = (0:0.001:10)';
t_size = length(t);

% inputs
u1 = ones(t_size,1);
u2 = sin(pi/2*t);
u3 = sin(pi*t);
u4 = sin(3*pi/4*t);
u5 = sin(2*pi*t);

% responses
if exist('y1')+exist('y2')+exist('y3')+exist('y4')+exist('y5') < 5
    y1 = lsim(L_cl, u1, t);
    y2 = lsim(L_cl, u2, t);
    y3 = lsim(L_cl, u3, t);
    y4 = lsim(L_cl, u4, t);
    y5 = lsim(L_cl, u5, t);
end%if

% plotting responses
figure
sgtitle('Closed-Loop Response for Varying Inputs')

subplot(5,1,1)
hold on
plot(t,u1,'r')
plot(t,y1)
ylabel('y_1(t)')
legend('\theta_r(t) = 1','location','best')
% legend('y_1(t)','\theta_r(t) = 1','location','best')
grid on
hold off

subplot(5,1,2)
hold on
plot(t,u2,'r')
plot(t,y2)
ylabel('y_2(t)')
legend('\theta_r(t) = sin(\pi/2*t)','location','best')
grid on
hold off

subplot(5,1,3)
hold on
plot(t,u3,'r')
plot(t,y3)
ylabel('y_3(t)')
legend('\theta_r(t) = sin(\pi*t)','location','best')
grid on
hold off

subplot(5,1,4)
hold on
plot(t,u4,'r')
plot(t,y4)
ylabel('y_4(t)')
legend('\theta_r(t) = sin(3\pi/4*t)','location','best')
grid on
hold off

subplot(5,1,5)
hold on
plot(t,u5,'r')
plot(t,y5)
xlabel('Time (seconds)')
ylabel('y_5(t)')
legend('\theta_r(t) = sin(2\pi*t)','location','best')
grid on
hold off

toc