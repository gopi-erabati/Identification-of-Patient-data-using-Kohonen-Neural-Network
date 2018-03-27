%% This file contains all the three projects and corresponding results are 
% displayed in command window and plotted accordingly

clc; clear all; close all;

%% project I

% data to train the network
train_data1 = [1 1 0 0; 0 0 0 1;1 0 0 0; 0 0 1 1];

% intital learning rate 
learn_rate = 0.6;

% to print appropriate cluster data
proj_num = 1;

% train the network and calculation of weights
% the convergence of weights as a function of number of iterations is
% plotted and the results of converged weights are shown in command window
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('Project I results :');
weights = kohonen_train( train_data1, learn_rate, proj_num );

% test the network with given test data
test_data1 = [0 0 0 0.9; 0 0 0.8 0.9;0.7 0 0 0; 0.7 0.9 0 0];
kohonen_test( test_data1, weights, proj_num );

%% Project II

% data to train the network
train_data2 = load('./control.txt');
train_data2 = [train_data2; load('./patient.txt')];

% intital learning rate
learn_rate = 0.6;

% to print appropriate cluster data
proj_num = 2;

% train the network and calculation of weights
% the convergence of weights as a function of number of iterations is
% plotted and the results of converged weights are shown in command window
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('Project II results :');
[weights,clu_control] = kohonen_train( train_data2, learn_rate, proj_num );

%% Project III

% test the network with given test gopi.txt test data
test_data2 = load('./gopi.txt');
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('Project III results :');
kohonen_test( test_data2, weights, proj_num, clu_control );
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');


%% this part of code is to visualize the weights and data as histograms
figure(3)
subplot(2,3,1)
bar(weights(:,1))
title('weights cluster 1')

subplot(2,3,2)
bar(test_data2(1,:))
title('data1');

subplot(2,3,3)
bar(test_data2(2,:))
title('data2');

subplot(2,3,4)
bar(weights(:,2))
title('weights cluster 2')

subplot(2,3,5)
bar(test_data2(3,:))
title('data3');

subplot(2,3,6)
bar(test_data2(4,:))
title('data4');