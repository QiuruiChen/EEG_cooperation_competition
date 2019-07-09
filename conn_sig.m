clear all; close all; clc;
addpath('D:\software\fieldtrip-20190325');
addpath('D:\software\eeglab14_1_2b');
addpath('D:\work\eeg\2PersonPongGame\f_PlotEEG_BrainNetwork');
%%  permutate p values
% for each group, do permutation test 100 times
conn_phase = load('data/useful/conn/conn_phase_spectcoher','conn_phase_spectcoher');
% get INS
com_conn = reshape(conn_phase.conn_phase_spectcoher.compet.beta,[42,42,25]);
cop_conn = reshape(conn_phase.conn_phase_spectcoher.cop.beta,[42,42,26]);
% for MI: above three lines are different 
% MI_all = load('data/useful/conn/MI_all','MI_all');
% com_conn = reshape(MI_all.MI_all.compet,[42,42,23]);
% cop_conn = reshape(MI_all.MI_all.cop,[42,42,17]);

com_conn = com_conn(1:21,22:42,:); cop_conn = cop_conn(1:21,22:42,:);
com_conn = reshape(com_conn,[21*21,23]); cop_conn = reshape(cop_conn,[21*21,17]);
com_conn = com_conn';cop_conn = cop_conn';

[trialNum combinedElectrodes] = size(com_conn);
for elecI = 1:combinedElectrodes
    temp_com = nonzeros(com_conn(:,elecI));
    temp_com = temp_com(~isnan(temp_com)); % remove NaN
    temp_cop = nonzeros(cop_conn(:,elecI));
    temp_cop = temp_cop(~isnan(temp_cop));
    temp_com_num = size(temp_com,1); 
    temp_cop_num = size(temp_cop,1);
    total_num = temp_com_num+temp_cop_num;
    p_real = ranksum(temp_com',temp_cop'); % Wilcoxon rank sum test
    p_phase_spectcoher(elecI) = p_real;
    
    disp('computing permutation test');
    for permuteI = 1:500
        temp_com_num_temp = randi(temp_com_num);
        % check randomly selected number 
        % X = [num2str(temp_com_num_temp),' is the random number selected'];disp(X); 
        p_temp = ranksum(temp_com(1:temp_com_num_temp,:)',...
            vertcat(temp_com(temp_com_num_temp:end,:),temp_cop)'); 
        p_prem_list(permuteI) = p_temp;
    end
    p_phase_spectcoher_pn(elecI) = sum(p_prem_list>p_real)/1000;
    p_phase_spectcoher_pz(elecI) = 1-normcdf(p_real); 
%     figure; bar(p_prem_list);
end
save data/useful/conn/p_phase_spectcoher_pn p_phase_spectcoher_pn
save data/useful/conn/p_phase_spectcoher_pz p_phase_spectcoher_pz
save data/useful/conn/p_phase_spectcoher p_phase_spectcoher
%% mask p-value
% smmu p: signfinicant differentce
temp = load('data/useful/conn/p_phase_spectcoher_pn','p_phase_spectcoher_pn');
electrodes = {'FP1','FPz','FP2','F7','F3','Fz','F4','F8','T7','C3','Cz',...
    'C4','T8','P7','P3','Pz','P4','P8','O1','Oz','O2'};
for electrodeI = 1:21
    for electrodeII = 1:21
        electrodeCells{21*(electrodeI-1)+electrodeII} = strcat(electrodes{electrodeI},...
            electrodes{electrodeII});   
        electrodesCellNums{21*(electrodeI-1)+electrodeII} = [electrodeI,electrodeII];
    end 
end 
pn_variable_name = 'p_phase_spectcoher_pn';
qvalues = mafdr(temp.(pn_variable_name));  %fdr
importElectrodes = electrodeCells(intersect(find(temp.(pn_variable_name) < 0.005),find(qvalues < 0.005)));
imElectrodeIndex = electrodesCellNums(intersect(find(temp.(pn_variable_name) < 0.005),find(qvalues < 0.005)));
% importElectrodes = electrodeCells(find(temp.(pn_variable_name) < 0.005));
% imElectrodeIndex = electrodesCellNums(find(temp.(pn_variable_name) < 0.005));
for imI = 1:length(imElectrodeIndex)
    temp =imElectrodeIndex{imI};
    wlist(imI,1) = temp(1); 
    wlist(imI,2) = temp(2);
end
wlist(:,3) = 1;  % edge weights are 1 for all edges
% node weighst equals to node degree
first_node =  wlist(:,1)';
unique_indx = unique(first_node);
[count_first_node,~] = histc(first_node,unique(first_node));
nodes_weights = zeros(1,42);
for i =1:length(unique_indx)
    nodes_weights(unique_indx(i)) = count_first_node(i);
end
sec_node =  wlist(:,2)';
unique_indx = unique(sec_node);
[count_sec_node,~] = histc(sec_node,unique(sec_node));
for i =1:length(unique_indx)
    nodes_weights(unique_indx(i)+21) = count_sec_node(i);
end

f = figure('visible','off');
topoplot2(21, wlist,nodes_weights, 'n_nn2nx', 'nocb');
title('significnat diffrent spectcoher INS between cooperation and competition');
saveas(f,'pic/sig_cop_com_phase_spectcoher.png');