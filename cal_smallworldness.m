%% claculate small-worldness of averaged competitive/cooperational network
% clear all; close all;
% addpath('D:\work\eeg\2PersonPongGame\SmallWorldNess-master');
% load('data/useful/conn/conn_power','conn_power');
% load('data/useful/conn/conn_power_2','conn_power_2');
% load('data/useful/conn/power_all','power_all');
% load('data/useful/conn/power_all_2','power_all_2');
% spectral coherence
load('data/useful/conn/conn_phase_spectcoher','conn_phase_spectcoher');
load('data/useful/conn/conn_phase_spectcoher_2','conn_phase_spectcoher_2');
temp = horzcat(conn_phase_spectcoher.compet.beta,conn_phase_spectcoher_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]); 
A = adjacet_mat(W_compet); sm_signma_team.spectcoher.compet = cal_smi(A);
temp = horzcat(conn_phase_spectcoher.cop.beta,conn_phase_spectcoher_2.cop);
temp(isnan(temp)) = 0; W_cop = reshape(mean(temp,2),[42,42]);
A = adjacet_mat(W_cop); sm_signma_team.spectcoher.cop = cal_smi(A);

% pli
load('data/useful/conn/conn_phase_pli','conn_phase_pli');
load('data/useful/conn/conn_phase_pli_2','conn_phase_pli_2');
temp = horzcat(conn_phase_pli.compet.beta,conn_phase_pli_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]); 
A = adjacet_mat(W_compet); sm_signma_team.pli.compet = cal_smi(A);
temp = horzcat(conn_phase_pli.cop.beta,conn_phase_pli_2.cop);
temp(isnan(temp)) = 0; W_cop = reshape(mean(temp,2),[42,42]);
A = adjacet_mat(W_cop); sm_signma_team.pli.cop = cal_smi(A);

% ispc
load('data/useful/conn/conn_phase_ispc','conn_phase_ispc');
load('data/useful/conn/conn_phase_ispc_2','conn_phase_ispc_2');
temp = horzcat(conn_phase_ispc.compet.beta,conn_phase_ispc_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]); 
A = adjacet_mat(W_compet); sm_signma_team.ispc.compet = cal_smi(A);
temp = horzcat(conn_phase_ispc.cop.beta,conn_phase_ispc_2.cop);
temp(isnan(temp)) = 0; W_cop = reshape(mean(temp,2),[42,42]);
A = adjacet_mat(W_cop); sm_signma_team.ispc.cop = cal_smi(A);

% power
load('data/useful/conn/conn_power','conn_power');
load('data/useful/conn/conn_power_2','conn_power_2');
temp = horzcat(conn_power.compet.beta,conn_power_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]); 
A = adjacet_mat(W_compet); sm_signma_team.power.compet = cal_smi(A);
temp = horzcat(conn_power.cop.beta,conn_power_2.cop);
temp(isnan(temp)) = 0; W_cop = reshape(mean(temp,2),[42,42]);
A = adjacet_mat(W_cop); sm_signma_team.power.cop = cal_smi(A);

% MI
load('data/useful/conn/MI_all','MI_all');
load('data/useful/conn/MI_all_2','MI_all_2');
temp = horzcat(MI_all.compet.beta,MI_all_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]); 
A = adjacet_mat(W_compet); sm_signma_team.MI.compet = cal_smi(A);
temp = horzcat(MI_all.cop.beta,MI_all_2.cop);
temp(isnan(temp)) = 0; W_cop = reshape(mean(temp,2),[42,42]);
A = adjacet_mat(W_cop); sm_signma_team.MI.cop = cal_smi(A);

save data/useful/conn/sm_signma_team sm_signma_team
%% intra-brain smallworld ness
clear all; close all;clc;
% spectral coherence
load('data/useful/conn/conn_phase_spectcoher','conn_phase_spectcoher');
load('data/useful/conn/conn_phase_spectcoher_2','conn_phase_spectcoher_2');
temp = horzcat(conn_phase_spectcoher.compet.beta,conn_phase_spectcoher_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]);
% select teh first person and the second person, calculate averaged SM
sm_signma_interBrain.spectcoher.compet =  (cal_smi(adjacet_mat(W_compet(1:21,1:21)))+...
    cal_smi(adjacet_mat(W_compet(22:42,22:42))))/2;
temp = horzcat(conn_phase_spectcoher.cop.beta,conn_phase_spectcoher_2.cop);
temp(isnan(temp)) = 0; W_cop = reshape(mean(temp,2),[42,42]);
sm_signma_interBrain.spectcoher.cop =  (cal_smi(adjacet_mat(W_cop(1:21,1:21)))+...
    cal_smi(adjacet_mat(W_cop(22:42,22:42))))/2;

% pli
load('data/useful/conn/conn_phase_pli','conn_phase_pli');
load('data/useful/conn/conn_phase_pli_2','conn_phase_pli_2');
temp = horzcat(conn_phase_pli.compet.beta,conn_phase_pli_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]);
% select teh first person and the second person, calculate averaged SM
sm_signma_interBrain.pli.compet =  (cal_smi(adjacet_mat(W_compet(1:21,1:21)))+...
    cal_smi(adjacet_mat(W_compet(22:42,22:42))))/2;
temp = horzcat(conn_phase_pli.cop.beta,conn_phase_pli_2.cop);
temp(isnan(temp)) = 0; W_cop = reshape(mean(temp,2),[42,42]);
sm_signma_interBrain.pli.cop =  (cal_smi(adjacet_mat(W_cop(1:21,1:21)))+...
    cal_smi(adjacet_mat(W_cop(22:42,22:42))))/2;

% ispc
load('data/useful/conn/conn_phase_ispc','conn_phase_ispc');
load('data/useful/conn/conn_phase_ispc_2','conn_phase_ispc_2');
temp = horzcat(conn_phase_ispc.compet.beta,conn_phase_ispc_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]);
% select teh first person and the second person, calculate averaged SM
sm_signma_interBrain.ispc.compet =  (cal_smi(adjacet_mat(W_compet(1:21,1:21)))+...
    cal_smi(adjacet_mat(W_compet(22:42,22:42))))/2;
temp = horzcat(conn_phase_ispc.cop.beta,conn_phase_ispc_2.cop);
temp(isnan(temp)) = 0; W_cop = reshape(mean(temp,2),[42,42]);
sm_signma_interBrain.ispc.cop =  (cal_smi(adjacet_mat(W_cop(1:21,1:21)))+...
    cal_smi(adjacet_mat(W_cop(22:42,22:42))))/2;


load('data/useful/conn/conn_power','conn_power');
load('data/useful/conn/conn_power_2','conn_power_2');
temp = horzcat(conn_power.compet.beta,conn_power_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]);
% select teh first person and the second person, calculate averaged SM
sm_signma_interBrain.power.compet =  (cal_smi(adjacet_mat(W_compet(1:21,1:21)))+...
    cal_smi(adjacet_mat(W_compet(22:42,22:42))))/2;
temp = horzcat(conn_power.cop.beta,conn_power_2.cop);
temp(isnan(temp)) = 0; W_cop = reshape(mean(temp,2),[42,42]);
sm_signma_interBrain.power.cop =  (cal_smi(adjacet_mat(W_cop(1:21,1:21)))+...
    cal_smi(adjacet_mat(W_cop(22:42,22:42))))/2;


load('data/useful/conn/MI_all','MI_all');
load('data/useful/conn/MI_all_2','MI_all_2');
temp = horzcat(MI_all.compet,MI_all_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]);
% select teh first person and the second person, calculate averaged SM
sm_signma_interBrain.MI.compet =  (cal_smi(adjacet_mat(W_compet(1:21,1:21)))+...
    cal_smi(adjacet_mat(W_compet(22:42,22:42))))/2;
temp = horzcat(MI_all.cop,MI_all_2.cop);
temp(isnan(temp)) = 0; W_cop = reshape(mean(temp,2),[42,42]);
sm_signma_interBrain.MI.cop =  (cal_smi(adjacet_mat(W_cop(1:21,1:21)))+...
    cal_smi(adjacet_mat(W_cop(22:42,22:42))))/2;

save data/useful/conn/sm_signma_interBrain sm_signma_interBrain

function  S_trans = cal_smi(A)
% analysis parameters
Num_ER_repeats = 100;  % to estimate C and L numerically for E-R random graph
Num_S_repeats = 1000; % to get P-value for S; min P = 0.001 for 1000 samples
I = 0.95;
FLAG_Cws = 1;
FLAG_Ctransitive = 2;

n = size(A,1);  % number of nodes
k = sum(A);  % degree distribution of undirected network
m = sum(k)/2;
K = mean(k); % mean degree of network
% computing small-world-ness using the analytical approximations for the E-R graph
[expectedC,expectedL] = ER_Expected_L_C(K,n);  % L_rand and C_rand
% [S_ws,~,~] = small_world_ness(A,expectedL,expectedC,FLAG_Cws);  % Using WS clustering coefficient
[S_trans,~,~] = small_world_ness(A,expectedL,expectedC,FLAG_Ctransitive);  %  Using transitive clustering coefficient
end