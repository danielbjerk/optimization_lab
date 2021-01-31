%% Just press f5 to run everything, and read the section that has something you need

% Press (ctrl+enter) to run the section your cursor is currently in ( Marked in yellow)
clear all
close all

%% Init one file
input = load('p4t5_kalman-feedback-optimal-tuning_e-dot-and-e-dot-c_vs-tilde-fix.mat');
plot_title = 'Kalman estimator feedback, optimal tuning, elevation rate';
file_name = 'p4t5_kalman-feedback-optimal-tuning_e_dot';
xaxis = 'Time [s]';
yaxis = 'Elevation rate [rad/s]';

time = input.ans(1,:);
setpoint = input.ans(3,:);
values = input.ans(2,:);
%values2 = input.ans(2,:);

time_start = 5;
time_end = 70;


% figure; % Calling figure => Plot/write in a new window
hold on
title(plot_title);
plot(time, setpoint);
plot(time, values);
%plot(time, values2);
xlim([time_start time_end]);


% Set desctiptions on the axis
xlabel(xaxis);
ylabel(yaxis);

lgd = legend('Estimate', 'Reference');
lgd.Location = 'southeast';
%lgd.Position(1:2) = [.7 .02];

%% Init multiple files
figure
input1 = load('p4tx_kalman-wrong-initialization-of-e-offset_e.mat');
input2 = load('p4tx_kalman-correct-initialization-of-e-offset_e.mat');
%input3 = load('p4t4_testing-disable-new-data_P_est_55and66.mat');
%input4 = load('p1t3_pole-placement-a=-1-b=2-with-elev_pitch-measurement_v1.mat');
plot_title = 'Effect of different choices of x\^(0)';
file_name = 'p4tx_correct-choice-of-x-est';
xaxis = 'Time [s]';
yaxis = 'Elevation [rad]';

time1 = input1.ans(1,:);
reference1 = input1.ans(2,:);
values1 = input1.ans(3,:);

time2 = input2.ans(1,:);
reference2 = input2.ans(2,:);
values2 = input2.ans(3,:);

% time3 = input3.ans(1,:);
% reference3 = input3.ans(2,:);
% values3 = input3.ans(3,:);

%time4 = input4.ans(1,:);
%reference4 = input4.ans(2,:);
%values3 = input3.ans(2,:);

time_start = 0;
time_end = 3;


% figure; % Calling figure => Plot/write in a new window
hold on
title(plot_title);

plot(time1, reference1);
plot(time1, values1);
plot(time2, reference2);
plot(time2, values2);
% plot(time3, reference3);
% plot(time3, values3);
%plot(time4, reference4);
% plot(time4, values4);
xlim([time_start time_end]);


% Set desctiptions on the axis
xlabel(xaxis);
ylabel(yaxis);

lg = legend('Encoder measurement, x\^(0) = 0', 'Kalman estimate, x\^(0) = 0', 'Encoder measurement, x\^(0) = e_{offset}', 'Kalman estimate, x\^(0) = e_{offset}');

%% Plot multiple plots in same figure
figure
input1 = load('p4t4_testing-disable-new-data_P_est_11and22.mat');
input2 = load('p4t4_testing-disable-new-data_P_est_33and44.mat');
input2 = load('p4t4_testing-disable-new-data_P_est_55and66.mat');
%input3 = load('p3t1_acc-and-enc-multiple-axis-transformed_travel.mat');
plot_title = 'Results with optimal tuning of L';
file_name = 'p3t4_conv-l-dot-corrected';

time1 = input1.ans(1,:);
reference1 = input1.ans(2,:);
values1 = input1.ans(3,:);

%reference1 = cumtrapz(time1, reference1);
%values1 = cumtrapz(time1, values1);

time2 = input2.ans(1,:);
reference2 = input2.ans(2,:);
values2 = input2.ans(3,:);

%reference2 = cumtrapz(time2, reference2);
%values2 = cumtrapz(time2, values2);

time3 = input3.ans(1,:);
reference3 = input3.ans(2,:);
values3 = input3.ans(3,:);

time_start = 0;
time_end = time1(end);



hold on

subplot(3,1,1);
p1 = plot(time1, reference1);
%p1.legend('Encoder measurement');
title(plot_title);
xaxis = 'Time [s]';
yaxis = '';
%xlabel(xaxis);
ylabel(yaxis);
time_start = 0; 
time_end = time_end;  
xlim([time_start time_end]);


subplot(3,1,2);
p2 = plot(time2, values2, 'g', time2, reference2);
%p2.legend('Encoder measurement', 'IMU measurement');
xaxis = 'Time [s]';
yaxis = '';
%xlabel(xaxis);
ylabel(yaxis);
xlim([time_start time_end]);


subplot(3,1,3);
h(:,3) = plot(time3, reference3, time3, values3);
xaxis = 'Time [s]';
yaxis = '';
xlabel(xaxis);
ylabel(yaxis);
xlim([time_start time_end]);

lg = legend('IMU measurement', 'IMU measurement corrected', 'Encoder measurement');
lg.Position(1:2) = [.6 .02];


%% Plot a lot of figures together
figure
input1 = load('p4t5_optimal-tuning_p.mat');
input2 = load('p4t5_optimal-tuning_p_dot.mat');
input3 = load('p4t5_optimal-tuning_e.mat');
input4 = load('p4t5_optimal-tuning_e_dot.mat');
input5 = load('p4t5_optimal-tuning_l.mat');
input6 = load('p4t5_optimal-tuning_l_dot.mat');

plot_title = 'Kalman estimates';
file_name = 'p4t5_optimal-kalman-tuning';

time1 = input1.ans(1,:);
est1 = input1.ans(2,:);
enc1 = input1.ans(3,:);

time2 = input2.ans(1,:);
est2 = input2.ans(2,:);
enc2 = input2.ans(3,:);

time3 = input3.ans(1,:);
est3 = input3.ans(2,:);
enc3 = input3.ans(3,:);

time4 = input4.ans(1,:);
est4 = input4.ans(2,:);
enc4 = input4.ans(3,:);

time5 = input5.ans(1,:);
est5 = input5.ans(2,:);
enc5 = input5.ans(3,:);

time6 = input6.ans(1,:);
est6 = input6.ans(2,:);
enc6 = input6.ans(3,:);

time_start = 5;
time_end = 40;


hold on

subplot(3,2,1);
p1 = plot(time1, est1, time1, enc1);
%title(plot_title);
xaxis = 'Time [s]';
yaxis = 'Pitch [rad]';
xlabel(xaxis);
ylabel(yaxis);
xlim([time_start time_end]);


subplot(3,2,2);
p2 = plot(time2, est2, time2, enc2);
xaxis = 'Time [s]';
yaxis = 'Pitch rate [rad/s]';
xlabel(xaxis);
ylabel(yaxis);
xlim([time_start time_end]);
ylim([-1,1]);


subplot(3,2,3);
p3 = plot(time3, est3, time3, enc3);
xaxis = 'Time [s]';
yaxis = 'Elevation [rad]';
xlabel(xaxis);
ylabel(yaxis);
xlim([time_start time_end]);

subplot(3,2,4);
p4 = plot(time4, est4, time4, enc4);
xaxis = 'Time [s]';
yaxis = 'Elevation rate [rad/s]';
xlabel(xaxis);
ylabel(yaxis);
xlim([time_start time_end]);

subplot(3,2,5);
p5 = plot(time5, est5, time5, enc5);
xaxis = 'Time [s]';
yaxis = 'Travel [rad/s]';
xlabel(xaxis);
ylabel(yaxis);
xlim([time_start time_end]);

subplot(3,2,6);
p5 = plot(time6, est6, time6, enc6);
xaxis = 'Time [s]';
yaxis = 'Travel rate [rad/s]';
xlabel(xaxis);
ylabel(yaxis);
xlim([time_start time_end]);

lg = legend('Encoder measurement', 'Kalman estimate');
lg.Position(1:2) = [.6 .02];


%% Plot only part of plot
time_start = 55; 
time_end = 75;  
xlim([time_start time_end]);


%% Legend
% Legend must come after you call plot()
% GIves a name to the plotted lines
%   
lgd = legend('Flying helicopter', 'Stationary helicopter'); 
lgd.Location = 'southeast';
%legend('Measured value, Q = 20'); 
hold off

%% Save plot
% TO save the current plot use:
    % print( filename, '-d'+ filename )
    % Use epsc instad of eps to get colours
print(file_name, '-djpeg');
print(file_name, '-depsc');

