% calculate network peroperties and save them 
clear all; close all; clc; 
addpath('D:\work\eeg\Final\last15s\2019_03_03_BCT');
addpath('D:\software\eeglab14_1_2b');
%% average all trials for cooperation and copition: undirected weighted network
% replace cop with cop;
load('data/useful/conn/conn_phase_pli','conn_phase_pli');
load('data/useful/conn/conn_phase_pli_2','conn_phase_pli_2');
W = reshape(mean(horzcat(conn_phase_pli.cop.beta,conn_phase_pli_2.cop),2),[42,42]);
W_nrm = adjacet_mat(W);
prop_cop_pli = cal_network_property(W_nrm);
save(strcat('data/useful/network/prop_cop_pli'),'prop_cop_pli');

clear all;close all;clc;
load('data/useful/conn/conn_phase_ispc','conn_phase_ispc');
load('data/useful/conn/conn_phase_ispc_2','conn_phase_ispc_2');
W = reshape(mean(horzcat(conn_phase_ispc.cop.beta,conn_phase_ispc_2.cop),2),[42,42]);
W_nrm = adjacet_mat(W);
prop_cop_ispc = cal_network_property(W_nrm);
save(strcat('data/useful/network/prop_cop_ispc'),'prop_cop_ispc');

clear all;close all;clc;
load('data/useful/conn/conn_phase_spectcoher','conn_phase_spectcoher');
load('data/useful/conn/conn_phase_spectcoher_2','conn_phase_spectcoher_2');
temp = horzcat(conn_phase_spectcoher.compet.beta,conn_phase_spectcoher_2.compet);
temp(isnan(temp)) = 0;
W = reshape(mean(temp,2),[42,42]); % change compet into compet
W_nrm = adjacet_mat(W);
prop_compet_spectcoher = cal_network_property(W_nrm);
save(strcat('data/useful/network/prop_compet_spectcoher'),'prop_compet_spectcoher');

clear all;close all;clc;
load('data/useful/conn/conn_power','conn_power');
load('data/useful/conn/conn_power_2','conn_power_2');
temp = horzcat(conn_power.compet.beta,conn_power_2.compet);
temp(isnan(temp)) = 0;
W = reshape(mean(temp,2),[42,42]); % change compet into compet
W_nrm = adjacet_mat(W);
prop_compet_power = cal_network_property(W_nrm);
save(strcat('data/useful/network/prop_compet_power'),'prop_compet_power');

clear all;close all;clc;
load('data/useful/conn/MI_all','MI_all');
load('data/useful/conn/MI_all_2','MI_all_2');
W = reshape(mean(horzcat(MI_all.cop,MI_all_2.cop),2),[42,42]);
W = reshape(mean(MI_all.cop,2),[42,42]); % change cop into cop
W_nrm = adjacet_mat(W);
prop_cop_MI = cal_network_property(W_nrm);
save(strcat('data/useful/network/prop_cop_MI'),'prop_cop_MI');
