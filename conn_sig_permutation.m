% calculating statistically signifincant INS between cooperation and
% competition
clear all; close all; clc;
addpath('D:\software\fieldtrip-20190325');
addpath('D:\software\eeglab14_1_2b');
addpath('D:\work\eeg\2PersonPongGame\f_PlotEEG_BrainNetwork');

conn_phase_ispc_per = zeros(1,441); %21x21 = 441
conn_phase_ispc = load('data/useful/conn/conn_phase_ispc','conn_phase_ispc');
com_conn = reshape(conn_phase_ispc.conn_phase_spectcoher.compet.beta,[42,42,22]);
cop_conn = reshape(conn_phase_ispc.conn_phase_spectcoher.cop.beta,[42,42,25]);
[conn_phase_ispc_per] = permutation_test(com_conn,cop_conn,conn_phase_ispc_per);
save data/useful/conn/conn_phase_ispc_per conn_phase_ispc_per

conn_phase_pli_per = zeros(1,441);
conn_phase_pli = load('data/useful/conn/conn_phase_pli','conn_phase_pli');
com_conn = reshape(conn_phase_pli.conn_phase_spectcoher.compet.beta,[42,42,22]);
cop_conn = reshape(conn_phase_pli.conn_phase_spectcoher.cop.beta,[42,42,25]);
[conn_phase_pli_per] = permutation_test(com_conn,cop_conn,conn_phase_pli_per);
save data/useful/conn/conn_phase_pli_per conn_phase_pli_per

conn_phase_spectcoher_per = zeros(1,441);
conn_phase_spectcoher = load('data/useful/conn/conn_phase_spectcoher','conn_phase_spectcoher');
com_conn = reshape(conn_phase_spectcoher.conn_phase_spectcoher.compet.beta,[42,42,22]);
cop_conn = reshape(conn_phase_spectcoher.conn_phase_spectcoher.cop.beta,[42,42,25]);
[conn_phase_spectcoher_per] = permutation_test(com_conn,cop_conn,conn_phase_spectcoher_per);
save data/useful/conn/conn_phase_spectcoher_per conn_phase_spectcoher_per

MI_all_per = zeros(1,441);
MI_all = load('data/useful/conn/MI_all','MI_all');
com_conn = reshape(MI_all.MI_all.compet,[42,42,22]);
cop_conn = reshape(MI_all.MI_all.cop,[42,42,25]);
[MI_all_per] = permutation_test(com_conn,cop_conn,MI_all_per);
save data/useful/conn/MI_all_per MI_all_per

conn_power_per = zeros(1,441); 
conn_power = load('data/useful/conn/conn_power','conn_power');
com_conn = reshape(conn_power.conn_power.compet.beta,[42,42,22]);
cop_conn = reshape(conn_power.conn_power.cop.beta,[42,42,25]);
[conn_power_per] = permutation_test(com_conn,cop_conn,conn_power_per);
save data/useful/conn/conn_power_per conn_power_per

%% draw pic; two-side p value: 0.0005; FDR: 0.005 
temp = load('data/useful/conn/conn_power_per','conn_power_per');
draw_sig_INS(temp,'conn_power_per','power');

temp = load('data/useful/conn/MI_all_per','MI_all_per');
draw_sig_INS(temp,'MI_all_per','MI');

temp = load('data/useful/conn/conn_phase_spectcoher_per','conn_phase_spectcoher_per');
draw_sig_INS(temp,'conn_phase_spectcoher_per','spectcoher');

temp = load('data/useful/conn/conn_phase_spectcoher_ispc_per','conn_phase_spectcoher_ispc_per');
draw_sig_INS(temp,'conn_phase_spectcoher_ispc_per','ispc');

temp = load('data/useful/conn/conn_phase_spectcoher_pli_per','conn_phase_spectcoher_pli_per');
draw_sig_INS(temp,'conn_phase_spectcoher_pli_per','pli');

%%  draw common significant INS on all phase-based FC
temp_pli = load('data/useful/conn/p_phase_pli_per','p_phase_pli_per');
temp_ispc = load('data/useful/conn/p_phase_ispc_per','p_phase_ispc_per');
temp_spectcoher = load('data/useful/conn/p_phase_spectcoher_per','p_phase_spectcoher_per');
electrodes = {'FP1','FPz','FP2','F7','F3','Fz','F4','F8','T7','C3','Cz',...
    'C4','T8','P7','P3','Pz','P4','P8','O1','Oz','O2'};
for electrodeI = 1:21
    for electrodeII = 1:21
        electrodeCells{21*(electrodeI-1)+electrodeII} = strcat(electrodes{electrodeI},...
            electrodes{electrodeII});   
        electrodesCellNums{21*(electrodeI-1)+electrodeII} = [electrodeI,electrodeII];
    end 
end 
pn_variable_name_pli = 'p_phase_pli_per'; qvalues_pli = mafdr(temp_pli.(pn_variable_name_pli));  %fdr
pn_variable_name_ispc = 'p_phase_ispc_per'; qvalues_ispc = mafdr(temp_ispc.(pn_variable_name_ispc));  %fdr
pn_variable_name_spectcoher = 'p_phase_spectcoher_per'; qvalues_spectcoher = mafdr(temp_spectcoher.(pn_variable_name_spectcoher));  %fdr

PLI_intersect = intersect(find(temp_pli.(pn_variable_name_pli) < 0.0005),find(qvalues_pli < 0.005));
ISPC_intersect = intersect(find(temp_ispc.(pn_variable_name_ispc) < 0.0005),find(qvalues_ispc < 0.005));
spectcoher_intersect = intersect(find(temp_spectcoher.(pn_variable_name_spectcoher) < 0.0005),find(qvalues_spectcoher < 0.005));
importElectrodes = electrodeCells(intersect(intersect(PLI_intersect,ISPC_intersect),spectcoher_intersect));
imElectrodeIndex = electrodesCellNums(intersect(intersect(PLI_intersect,ISPC_intersect),spectcoher_intersect));
draw_brain_map(imElectrodeIndex,'phase') % statistically significant INS appeared in all phase-based NS

%% 
function [conn_per] = permutation_test(com_conn,cop_conn,conn_per)
com_conn = com_conn(1:21,22:42,:); cop_conn = cop_conn(1:21,22:42,:);
com_conn = reshape(com_conn,[21*21,22]); cop_conn = reshape(cop_conn,[21*21,25]);
com_conn = com_conn';cop_conn = cop_conn';

[~, combinedElectrodes] = size(com_conn);
for elecI = 1:combinedElectrodes
    temp_com = nonzeros(com_conn(:,elecI));
    temp_com = temp_com(~isnan(temp_com)); % remove NaN
    temp_cop = nonzeros(cop_conn(:,elecI));
    temp_cop = temp_cop(~isnan(temp_cop));
    temp_com_num = size(temp_com,1); 
    real = abs(mean(temp_cop) - mean(temp_com));
    disp('computing permutation test');
    for permuteI = 1:500
        temp_com_num_temp = randi(temp_com_num); % randomly select trails from competition set
        p_prem_list(permuteI)  = abs(mean(temp_com(1:temp_com_num_temp,:))...
            - mean(vertcat(temp_com(temp_com_num_temp:end,:),temp_cop)));
    end
    conn_per(elecI) = sum(p_prem_list> real)/500;
end
end

function draw_sig_INS(temp,pn_variable_name,saveName)
electrodes = {'FP1','FPz','FP2','F7','F3','Fz','F4','F8','T7','C3','Cz',...
    'C4','T8','P7','P3','Pz','P4','P8','O1','Oz','O2'};
for electrodeI = 1:21
    for electrodeII = 1:21
        electrodeCells{21*(electrodeI-1)+electrodeII} = strcat(electrodes{electrodeI},...
            electrodes{electrodeII});   
        electrodesCellNums{21*(electrodeI-1)+electrodeII} = [electrodeI,electrodeII];
    end 
end 
qvalues = mafdr(temp.(pn_variable_name));  %fdr
importElectrodes = electrodeCells(intersect(find(temp.(pn_variable_name) < 0.005),find(qvalues < 0.005)));
imElectrodeIndex = electrodesCellNums(intersect(find(temp.(pn_variable_name) < 0.005),find(qvalues < 0.005)));
draw_brain_map(imElectrodeIndex,saveName)
end

function draw_brain_map(imElectrodeIndex,saveName)
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
%     title('significnat diffrent MI INS between cooperation and competition');
    saveas(f,strcat('pic_2/sig_cop_com_',saveName,'.png'));
end