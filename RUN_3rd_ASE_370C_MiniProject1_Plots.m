% ASE_370C_MiniProject1 Plots
 close all

%% Nominal A matrix

% Signal r
rNom_response = rNom.data(:);
rNom_time = rNom.Time;

% Signal y
yNom_response = yNom.data(:);
yNom_time = yNom.Time;

% Signal u
uNom_response = uNom.data(:);
uNom_time = uNom.Time;

%% Perturbed A matrix

% Signal r
rPert_response = rPert.data(:);
rPert_time = rPert.Time;

% Signal y
yPert_response = yPert.data(:);
yPert_time = yPert.Time;

% Signal u
uPert_response = uPert.data(:);
uPert_time = uPert.Time;


%% Plots

figure
hold on

subplot(2,3,1)
plot(rNom_time, rNom_response)
xlabel('Time (s)')
ylabel('r_n_o_m')
grid on

subplot(2,3,2)
plot(yNom_time, yNom_response)
xlabel('Time (s)')
ylabel('y_n_o_m')
grid on
title('State Feedback Contoller Signals for a Simple Vectored-Thrust Aircraft')

subplot(2,3,3)
plot(uNom_time, uNom_response)
xlabel('Time (s)')
ylabel('u_n_o_m')
grid on

subplot(2,3,4)
plot(rPert_time, rPert_response)
xlabel('Time (s)')
ylabel('r_p_e_r_t')
grid on

subplot(2,3,5)
plot(yPert_time, yPert_response)
xlabel('Time (s)')
ylabel('y_p_e_r_t')
grid on

subplot(2,3,6)
plot(uPert_time, uPert_response)
xlabel('Time (s)')
ylabel('u_p_e_r_t')
grid on

hold off

% ======================================== %
%% Integral Action
% ======================================== %

%% Nominal A matrix

% Signal r
rNom_response_int = rNom_int.data(:);
rNom_time_int = rNom_int.Time;

% Signal y
yNom_response_int = yNom_int.data(:);
yNom_time_int = yNom_int.Time;

% Signal u
uNom_response_int = uNom_int.data(:);
uNom_time_int = uNom_int.Time;

%% Perturbed A matrix

% Signal r
rPert_response_int = rPert_int.data(:);
rPert_time_int = rPert_int.Time;

% Signal y
yPert_response_int = yPert_int.data(:);
yPert_time_int = yPert_int.Time;

% Signal u
uPert_response_int = uPert_int.data(:);
uPert_time_int = uPert_int.Time;

%% Plots

figure
hold on

subplot(2,3,1)
plot(rNom_time_int, rNom_response_int)
xlabel('Time (s)')
ylabel('r_n_o_m')
grid on

subplot(2,3,2)
plot(yNom_time_int, yNom_response_int)
xlabel('Time (s)')
ylabel('y_n_o_m')
grid on
title('Integral Action State Feedback Contoller Signals for a Simple Vectored-Thrust Aircraft')

subplot(2,3,3)
plot(uNom_time_int, uNom_response_int)
xlabel('Time (s)')
ylabel('u_n_o_m')
grid on

subplot(2,3,4)
plot(rPert_time_int, rPert_response_int)
xlabel('Time (s)')
ylabel('r_p_e_r_t')
grid on

subplot(2,3,5)
plot(yPert_time_int, yPert_response_int)
xlabel('Time (s)')
ylabel('y_p_e_r_t')
grid on

subplot(2,3,6)
plot(uPert_time_int, uPert_response_int)
xlabel('Time (s)')
ylabel('u_p_e_r_t')
grid on

hold off















