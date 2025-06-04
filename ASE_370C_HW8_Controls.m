tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ASE 370C: Feedback Control Systems
% Homework 8 MAIN FILE
close all; format long g; clc; %clear all;
set(0, 'DefaultAxesFontSize',12, 'DefaultLineLineWidth',1.,...
    'DefaultLineMarkerSize',16)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Problem 1
% System parameters
gam = 0.5;
k1 = 1;
k2 = 0.914;
l1 = 2.828;
l2 = 4;

% TFs
Ps = tf([gam 1], [1 0 0]);
Cs = tf([(k1*l1+k2*l2), k1*l2],[1 (gam*k1+k2+l1) (k1+l2+k2*l1-gam*k2*l2)]);
Ls = Ps*Cs;

% Plots
figure
hold on
subplot(1,2,1)
margin(Ls)
grid on
subplot(1,2,2)
amnyquist(Ls)
title('Nyquist Plot for L(s)')
hold off

TF = tf(Ps*Cs,1+Ps*Cs)
figure
margin(TF)

%% Problem 2
% system parameter
k = 1;

% Open-loop TF
Ls_2 = tf([k], [1,4,-5,0]);

% open-loop TF poles
poles = pole(Ls_2);

% Nyquist plot of open-loop TF
figure
amnyquist(Ls_2)
title('Nyquist Plot for Open-Loop Transfer Function L(s) w/ k=1')

%% Problem 3
% TFs
Ps_3 = tf([10],[1 10 29]);
Cs_3 = tf([1000 6010 60],[1 120 2000 0]);
Ls_3 = Ps_3*Cs_3;

% Bode & Nyquist Plots
figure
hold on
subplot(1,2,1)
margin(Ls_3)
grid on
subplot(1,2,2)
amnyquist(Ls_3)
title('Nyquist Plot for Open-Loop Transfer Function L(s)')
hold off

%% Problem 4
% Systems Parameters
z = (0.05:0.05:1)'; % damping ratios
w0 = 1; % natural frequency (rad/s)
kd = 2*z*w0; % derivative gain
kp = w0^2; % proportional gain

% Plant (double-integrator)
Ps_4 = tf([1],[1 0 0]);

% for-loop testing each damping ratio
nn = length(z);
gm = zeros(nn,1);
pm = zeros(nn,1);
for ii = 1:nn
    Cs_4 = tf([kd(ii) kp],1);
    Ls_4 = Ps_4*Cs_4;
    [gm(ii),pm(ii),~,~] = margin(Ls_4);
end%for

% figure
% amnyquist(Ls_4)
% 
% disp('Gain Margins')
% disp(gm)
% 
% disp('Phase Margins')
% disp(pm)

figure
sgtitle('Gain & Phase Margin as a Function of Damping Ratio for Open-Loop Transfer Function L(s)','FontSize', 16,'FontWeight','bold')
hold on
subplot(2,1,1)
plot(z,gm)
title('Gain Margin')
xlabel('\zeta')
ylabel('G_m')
grid on
subplot(2,1,2)
plot(z,pm)
title('Phase Margin')
xlabel('\zeta')
ylabel('\phi_m (deg)')
grid on
hold off




toc