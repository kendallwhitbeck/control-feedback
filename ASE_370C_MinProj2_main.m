tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ASE 370C: Feedback Control Systems
% Mini Project 2 MAIN FILE
close all; format short g; clc; %clear all;
set(0, 'DefaultAxesFontSize',14, 'DefaultLineLineWidth',2,...
    'DefaultLineMarkerSize',20)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Givens
K = 20;
G1 = tf([100],[1 100]);
G2 = tf([1],[4.8 8.2 0]);

%% Problem 9
% TF from d(t) to epsilon(t)
G_d_ep = (-(1/pi)*G2)/(1+K*G1*G2*(1/pi));
% G_d_ep = tf([-1 -100],[4.8*pi 488.2*pi 820*pi 100*K])

% Bode of TF from d(t) to epsilon(t)
figure
hold on
bode(G_d_ep)
title('Bode Diagram for Transfer Function from d(t) to \epsilon(t) w/ K=20')
grid on
hold off

%% Problem 12
% new control TF
C_s = tf([335.8, 1252],[1 4.845])

% new TF from d(t) to epsilon(t)
G_d_ep_C_s = (-(1/pi)*G2)/(1+C_s*G1*G2*(1/pi));

% Bode of TF from d(t) to epsilon(t)
figure
hold on
bode(G_d_ep_C_s)
title('Bode Diagram for Transfer Function from d(t) to \epsilon(t) w/ Updated Control TF, C(s)')
grid on
hold off

% Poles of new TF from d to eps
poles = pole(minreal(G_d_ep_C_s))


%%
toc