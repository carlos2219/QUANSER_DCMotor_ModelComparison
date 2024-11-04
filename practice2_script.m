%Instituto Tecnológico y de Estudios Superiores de Monterrey
%Name: Carlos Hernán Auquilla Larriva
%Course: Autonomy of Unmanned Aerial Vehicles
%Last update: August 13th 2024
clc; clear;close all;

%%Practice 2
%Load data
load('a00834778_comparison.mat');

%Period of time for analysis
init_time = 3;
final_time = 5;
init_index = init_time * 500 + 1;
final_index = final_time * 500 + 1;
partial_index = init_index:final_index; %Takes values from init_time to final_time

%Load only necessary data
t = data(1,partial_index);
voltage = data(2,partial_index);
ang_vel_real = data(3,partial_index);
ang_vel_zn = data(4,partial_index);
ang_vel_miller = data(5,partial_index);
ang_vel_an = data(6,partial_index);

%Plot section
subplot(2,1,1);
plot(t,ang_vel_real,"r");
ylabel('w_m(t) [rad/s]');
xlim([init_time final_time])
ylim([70 140])
grid on;

subplot(2,1,2); 
plot(t,voltage,"--b")
ylabel('V_m [V]');
xlabel('Time [sec]')
xlim([init_time final_time])
ylim([2 6])
grid on;

%Real response
figure;
plot(t,ang_vel_real,"r");
ylabel('w_m(t) [rad/s]');
xlabel('Time [sec]');
grid on;

%Comparison
%Ziegler-Nichols
r_zn = ang_vel_real - ang_vel_zn;
SS2_zn = norm(r_zn,2)^2; %The sum of squared errors


%Miller
r_miller = ang_vel_real - ang_vel_miller;
SS2_miller = norm(r_miller,2)^2;

%Analytic
r_an = ang_vel_real - ang_vel_an;
SS2_an = norm(r_an,2)^2;

figure;
labels_error = categorical({'Ziegler-Nichols','Miller','Analytic'});
labels_error = reordercats(labels_error,{'Ziegler-Nichols','Miller','Analytic'});
SS2 = [SS2_zn; SS2_miller; SS2_an];
bar(labels_error,SS2);
title("Model error comparison")






