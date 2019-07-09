clear all; close all; clc;
addpath('D:\work\eeg\Final\last15s\SmallWorldNess-master');
% power
load('data/useful/conn/conn_power','conn_power');
load('data/useful/conn/conn_power_2','conn_power_2');
temp = horzcat(conn_power.compet.beta,conn_power_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]); 
A = adjacet_mat(W_compet);
GE_team.power.compet = efficiency_wei(A);
temp = horzcat(conn_power.cop.beta,conn_power_2.cop);
temp(isnan(temp)) = 0;
W_cop = reshape(mean(temp,2),[42,42]); 
A = adjacet_mat(W_cop);
GE_team.power.cop = efficiency_wei(A);

% ispc
load('data/useful/conn/conn_phase_ispc','conn_phase_ispcs');
load('data/useful/conn/conn_phase_ispc_2','conn_phase_ispc_2');
temp = horzcat(conn_phase_ispc.compet,conn_phase_ispc_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]); 
A = adjacet_mat(W_compet);
GE_team.ispc.compet = efficiency_wei(A);
temp = horzcat(conn_phase_ispc.cop,conn_phase_ispc_2.cop);
temp(isnan(temp)) = 0;
W_cop = reshape(mean(temp,2),[42,42]); 
A = adjacet_mat(W_cop);
GE_team.ispc.cop = efficiency_wei(A);
% pli 
load('data/useful/conn/conn_phase_pli','conn_phase_pli');
load('data/useful/conn/conn_phase_pli_2','conn_phase_pli_2');
temp = horzcat(conn_phase_pli.compet,conn_phase_pli_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]); 
A = adjacet_mat(W_compet);
GE_team.pli.compet = efficiency_wei(A);
temp = horzcat(conn_phase_pli.cop,conn_phase_pli_2.cop);
temp(isnan(temp)) = 0;
W_cop = reshape(mean(temp,2),[42,42]); 
A = adjacet_mat(W_cop);
GE_team.pli.cop = efficiency_wei(A);
% spectcoher
load('data/useful/conn/conn_phase_spectcoher','conn_phase_spectcoher');
load('data/useful/conn/conn_phase_spectcoher_2','conn_phase_spectcoher_2');
temp = horzcat(conn_phase_spectcoher.compet,conn_phase_spectcoher_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]); 
A = adjacet_mat(W_compet);
GE_team.spectcoher.compet = efficiency_wei(A);
temp = horzcat(conn_phase_spectcoher.cop,conn_phase_spectcoher_2.cop);
temp(isnan(temp)) = 0;
W_cop = reshape(mean(temp,2),[42,42]); 
A = adjacet_mat(W_cop);
GE_team.spectcoher.cop = efficiency_wei(A);

%MI
load('data/useful/conn/MI_all','MI_all');
load('data/useful/conn/MI_all_2','MI_all_2');
temp = horzcat(MI_all.compet,MI_all_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]); 
A = adjacet_mat(W_compet);
GE_team.MI.compet = efficiency_wei(A);
temp = horzcat(MI_all.cop,MI_all_2.cop);
temp(isnan(temp)) = 0;
W_cop = reshape(mean(temp,2),[42,42]); 
A = adjacet_mat(W_cop);
GE_team.MI.cop = efficiency_wei(A);

save data/useful/conn/GE_team GE_team

%% winthin-brain smallworld ness
clear all; close all;clc;
% ispc
load('data/useful/conn/conn_phase_spectcoher','conn_phase_spectcoher');
load('data/useful/conn/conn_phase_spectcoher_2','conn_phase_spectcoher_2');
temp = horzcat(conn_phase_spectcoher.compet.beta,conn_phase_spectcoher_2.compet);
temp(isnan(temp)) = 0;
W_compet = reshape(mean(temp,2),[42,42]); 
GE_interBrain.ispc.compet =  (efficiency_wei(adjacet_mat(W_compet(1:21,1:21)))+...
efficiency_wei(adjacet_mat(W_compet(22:42,22:42))))/2;
temp = horzcat(conn_phase_spectcoher.cop.beta,conn_phase_spectcoher_2.cop);
temp(isnan(temp)) = 0;
W_cop = reshape(mean(temp,2),[42,42]); 
GE_interBrain.ispc.cop = (efficiency_wei(adjacet_mat(W_cop(1:21,1:21)))+...
efficiency_wei(adjacet_mat(W_cop(22:42,22:42))))/2;
% pli
load('data/useful/conn/conn_phase_pli','conn_phase_pli');
load('data/useful/conn/conn_phase_pli_2','conn_phase_pli_2');
temp = horzcat(conn_phase_pli.compet.beta,conn_phase_pli_2.compet);
temp(isnan(temp)) = 0;
W_compet = reshape(mean(temp,2),[42,42]); 
GE_interBrain.pli.compet =  (efficiency_wei(adjacet_mat(W_compet(1:21,1:21)))+...
efficiency_wei(adjacet_mat(W_compet(22:42,22:42))))/2;
temp = horzcat(conn_phase_pli.cop.beta,conn_phase_pli_2.cop);
temp(isnan(temp)) = 0;
W_cop = reshape(mean(temp,2),[42,42]); 
GE_interBrain.pli.cop = (efficiency_wei(adjacet_mat(W_cop(1:21,1:21)))+...
efficiency_wei(adjacet_mat(W_cop(22:42,22:42))))/2;
% spectcoher
load('data/useful/conn/conn_phase_spectcoher','conn_phase_spectcoher');
load('data/useful/conn/conn_phase_spectcoher_2','conn_phase_spectcoher_2');
temp = horzcat(conn_phase_spectcoher.compet.beta,conn_phase_spectcoher_2.compet);
temp(isnan(temp)) = 0;
W_compet = reshape(mean(temp,2),[42,42]); 
GE_interBrain.spectcoher.compet =  (efficiency_wei(adjacet_mat(W_compet(1:21,1:21)))+...
efficiency_wei(adjacet_mat(W_compet(22:42,22:42))))/2;
temp = horzcat(conn_phase_spectcoher.cop.beta,conn_phase_spectcoher_2.cop);
temp(isnan(temp)) = 0;
W_cop = reshape(mean(temp,2),[42,42]); 
GE_interBrain.spectcoher.cop = (efficiency_wei(adjacet_mat(W_cop(1:21,1:21)))+...
efficiency_wei(adjacet_mat(W_cop(22:42,22:42))))/2;

%power
load('data/useful/conn/conn_power','conn_power');
load('data/useful/conn/conn_power_2','conn_power_2');
temp = horzcat(conn_power.compet.beta,conn_power_2.compet);
temp(isnan(temp)) = 0;
W_compet = reshape(mean(temp,2),[42,42]); 
GE_interBrain.power.compet =  (efficiency_wei(adjacet_mat(W_compet(1:21,1:21)))+...
efficiency_wei(adjacet_mat(W_compet(22:42,22:42))))/2;
temp = horzcat(conn_power.cop.beta,conn_power_2.cop);
temp(isnan(temp)) = 0;
W_cop = reshape(mean(temp,2),[42,42]); 
GE_interBrain.power.cop = (efficiency_wei(adjacet_mat(W_cop(1:21,1:21)))+...
efficiency_wei(adjacet_mat(W_cop(22:42,22:42))))/2;

% MI
load('data/useful/conn/MI_all','MI_all');
load('data/useful/conn/MI_all_2','MI_all_2');
temp = horzcat(MI_all.compet,conn_phase_spectcoher_2.compet);
temp(isnan(temp)) = 0; W_compet = reshape(mean(temp,2),[42,42]); 
GE_interBrain.MI.compet =  (efficiency_wei(adjacet_mat(W_compet(1:21,1:21)))+...
efficiency_wei(adjacet_mat(W_compet(22:42,22:42))))/2;
temp = horzcat(MI_all.cop,conn_phase_spectcoher_2.cop);
temp(isnan(temp)) = 0; W_cop = reshape(mean(temp,2),[42,42]); 
GE_interBrain.MI.cop = (efficiency_wei(adjacet_mat(W_cop(1:21,1:21)))+...
efficiency_wei(adjacet_mat(W_cop(22:42,22:42))))/2;

save data/useful/conn/GE_interBrain GE_interBrain