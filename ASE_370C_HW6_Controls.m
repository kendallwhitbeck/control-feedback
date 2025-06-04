tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ASE 370C: Feedback Control Systems
% Homework 6 MAIN FILE
close all; format short g; clc; %clear all;
set(0, 'DefaultAxesFontSize',16, 'DefaultLineLineWidth',2,...
    'DefaultLineMarkerSize',20)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Problem 1, Part (b)
% Givens for System Response
Kf = 0.0; % some arbitrary reference gain
Acl = [-13.6 64; -1 0]; % closed-loop state coef matrix
B1 = [108*Kf; 1]; % reference signal coef vec
B2 = [108; 0]; % disturbance coef vec
B3 = [1.1; -1]; % noise coef vec
C = [1 0]; % response state coef vec
D = [0]; % response control input coef vec

% Givens for Controller Response
Kp = (2*.85*8-12.5)/108;
Ki = 16/27;
Cu = [-Kp Ki];
Du = Kf;

% Timespan of system response (seconds)
tspan = (0:0.01:12)';

% create piecewise function r(t) to vary input to system
syms r(t)
r(t) = piecewise(t<1,0, 1<=t<2,200, 2<=t<3,100, 3<=t<4,400, 4<=t<5,200,...
    5<=t<6,600, 6<=t<7,300, 7<=t<8,900, 8<=t<9,500, 9<=t<10,-200, ...
    10<=t<11,200, t>=11,0);

% converting values of r into numerical double rather than symbolic
r = double(r(tspan));

% Plant Response
sys_plant_1b = ss(Acl,B1,C,D);
y_1b = lsim(sys_plant_1b,r,tspan);

% Controller Response
sys_ctrl_1b = ss(Acl,B1,Cu,Du);
u_1b = lsim(sys_ctrl_1b,r,tspan);

% Plots
figure; hold on;
subplot(2,1,1); plot(tspan,y_1b); grid on;
title('System & Controller Response with No Disturbance');
xlabel('Time (seconds)'); ylabel('y(t)');
subplot(2,1,2); plot(tspan,u_1b); grid on;
xlabel('Time (seconds)'); ylabel('u(t)');
hold off

%% Problem 1, Part (c)

% create piecewise disturbance function d(t) to vary input to system
syms d(t)
d(t) = piecewise(t<1.5,0, 1.5<=t<3,-20, 3<=t<5,40,...
    5<=t<7,0, 7<=t<9,50, 9<=t<11,30, t>=11,0);

% converting values of d(t) into numerical double rather than symbolic
d = double(d(tspan));

% Plant Response
sys_plant_1c = ss(Acl,[B1,B2],C,D);
y_1c = lsim(sys_plant_1c,[r,d],tspan);

% Controller Response
sys_ctrl_1c = ss(Acl,[B1,B2],Cu,Du);
u_1c = lsim(sys_ctrl_1c,[r,d],tspan);

% Plots
figure; hold on;

subplot(2,1,1); plot(tspan,y_1c); grid on;
title('System & Controller Response with Disturbance');
xlabel('Time (seconds)'); ylabel('y(t)');

subplot(2,1,2); plot(tspan,u_1c); grid on;
xlabel('Time (seconds)'); ylabel('u(t)');

hold off

%% Problem 3
% Givens
w0 = 3; % natural frequency
Z = 0.9; % damping ratio (zeta)

% Defining the transfer functions (tf)
G1 = tf(w0^2 , [1, 2*Z*w0, w0^2]);
G2 = tf([2*Z*w0, 0] , [1, 2*Z*w0, w0^2]);
G3 = tf([1,0,0] , [1, 2*Z*w0, w0^2]);

% Timespan for problem 3
t = (0:0.01:10)';

% Input signals
u1 = sin(w0.*t./10);
u2 = sin(w0.*t);
u3 = sin(10*w0.*t);

% Plotting
figure
hold on
% Bode Plots
subplot(1,3,1); bode(G1); grid on;
title('G_1(s) Bode');
subplot(1,3,2); bode(G2); grid on;
title('G_2(s) Bode');
subplot(1,3,3); bode(G3); grid on;
title('G_3(s) Bode');
hold off

% Transfer Function Responses & Input Signals
figure; hold on

% Response + Input #1 Plots
subplot(3,3,1); plot(t,u1); lsimplot(G1,u1,t); grid on;
title('G_1(s) w/ Input u_1');
xlabel('','fontsize',0.1); ylabel('G_1*u_1');

subplot(3,3,2); plot(t,u1); lsimplot(G2,u1,t); grid on;
title('G_2(s) w/ Input u_1');
xlabel('','fontsize',0.1); ylabel('G_2*u_1');

subplot(3,3,3); plot(t,u1); lsimplot(G3,u1,t); grid on;
title('G_3(s) w/ Input u_1');
xlabel('','fontsize',0.1); ylabel('G_3*u_1');

% Response + Input #2 Plots
subplot(3,3,4); plot(t,u2); lsimplot(G1,u2,t); grid on;
title('G_1(s) w/ Input u_2');
xlabel('','fontsize',0.1); ylabel('G_1*u_2');

subplot(3,3,5); plot(t,u2); lsimplot(G2,u2,t); grid on;
title('G_2(s) w/ Input u_2');
xlabel('','fontsize',0.1); ylabel('G_2*u_2');

subplot(3,3,6); plot(t,u2); lsimplot(G3,u2,t); grid on;
title('G_3(s) w/ Input u_2');
xlabel('','fontsize',0.1); ylabel('G_3*u_2');

% Response + Input #3 Plots
subplot(3,3,7); plot(t,u3); lsimplot(G1,u3,t); grid on;
title('G_1(s) w/ Input u_3'); ylabel('G_1*u_3');

subplot(3,3,8); plot(t,u3); lsimplot(G2,u3,t); grid on;
title('G_2(s) w/ Input u_3'); ylabel('G_1*u_3');

subplot(3,3,9); plot(t,u3); lsimplot(G3,u3,t); grid on;
title('G_3(s) w/ Input u_3'); ylabel('G_1*u_3'); % xlim([0,0.5])

% legend('Input Signal','Response Signal')
hold off

% % Response signals for u1
% y11 = lsim(G1,u1,t);
% y12 = lsim(G2,u1,t);
% y13 = lsim(G3,u1,t);
% 
% % Response signals for u2
% y21 = lsim(G1,u2,t);
% y22 = lsim(G2,u2,t);
% y23 = lsim(G3,u2,t);
% 
% % Response signals for u3
% y31 = lsim(G1,u3,t);
% y32 = lsim(G2,u3,t);
% y33 = lsim(G3,u3,t);
% 
% % Plotting
% figure; hold on
% % Response + Input #1 Plots
% subplot(3,3,1); plot(t,u1); plot(t,y11); grid on;
% subplot(3,3,2); plot(t,u1); plot(t,y12); grid on;
% subplot(3,3,3); plot(t,u1); plot(t,y13); grid on;
% % Response + Input #2 Plots
% subplot(3,3,4); plot(t,u2); plot(t,y21); grid on;
% subplot(3,3,5); plot(t,u2); plot(t,y22); grid on;
% subplot(3,3,6); plot(t,u2); plot(t,y23); grid on;
% % Response + Input #3 Plots
% subplot(3,3,7); plot(t,u3); plot(t,y31); grid on;
% subplot(3,3,8); plot(t,u3); plot(t,y32); grid on;
% subplot(3,3,9); plot(t,u3); plot(t,y33); grid on;
% hold off



toc