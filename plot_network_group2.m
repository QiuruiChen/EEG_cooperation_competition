%% this code is responsible for ploting strong NS 
% intra-brain NS: threshold is visually detected by intra-brain NS distribution 
% inter-brain NS: the top 10 highest INS are chosen 
clear all; close all; clc;
addpath('f_PlotEEG_BrainNetwork');
addpath('D:\software\eeglab14_1_2b');
%% power-correlation
% cooperation
load('data/useful/conn/conn_power','conn_power');
load('data/useful/conn/conn_power_2','conn_power_2');
temp = horzcat(conn_power.cop.beta,conn_power_2.cop);
temp(isnan(temp)) = 0;
conn_power_cop = reshape(mean(temp,2),[42,42]); 
% plot distribution for intra- and inter-brain NS
% saveHist(conn_power_cop,'power-correlation','cooperative','power_cop');
target_mat = plot_strong_ns_top_10_gap(conn_power_cop,0.6,10); %intra-brain NS threshold is 0.6
save_strong_NS(target_mat,0,'cooperative','power_cop_strong'); 
% competition 
temp = horzcat(conn_power.compet.beta,conn_power_2.compet);
temp(isnan(temp)) = 0;
conn_power_compet = reshape(mean(temp,2),[42,42]);
% saveHist(conn_power_compet,'power-correlation','competitive','power_compet');
target_mat = plot_strong_ns_top_10_gap(conn_power_compet,0.6,10);
save_strong_NS(target_mat,0,'competitve','power_compet_strong'); 
%% ispc 
% cooperation
load('data/useful/conn/conn_phase_ispc','conn_phase_ispc');
load('data/useful/conn/conn_phase_ispc_2','conn_phase_ispc_2');
temp = horzcat(conn_phase_ispc.cop.beta,conn_phase_ispc_2.cop);
temp(isnan(temp)) = 0;
conn_power_cop = reshape(mean(temp,2),[42,42]); 
% saveHist(conn_power_cop,'ispc','cooperative','ispc_cop'); % plot the dist
[target_mat] = plot_strong_ns_top_10_gap(conn_power_cop,0.6,10);
save_strong_NS(target_mat,0,'cooperative','ispc_cop_strong'); 
% competiion 
temp = horzcat(conn_phase_ispc.compet.beta,conn_phase_ispc_2.compet);
temp(isnan(temp)) = 0;
conn_power_compet = reshape(mean(temp,2),[42,42]);
% saveHist(conn_power_compet,'ispc','competitive','ispc_compet'); 
[target_mat] = plot_strong_ns_top_10_gap(conn_power_compet,0.6,10);
save_strong_NS(target_mat,0,'competitive','ispc_compet_strong');
%% spectal coherene
% cooperation
load('data/useful/conn/conn_phase_spectcoher','conn_phase_spectcoher');
load('data/useful/conn/conn_phase_spectcoher_2','conn_phase_spectcoher_2');
temp = horzcat(conn_phase_spectcoher.cop.beta,conn_phase_spectcoher_2.cop);
temp(isnan(temp)) = 0;
conn_power_cop = reshape(mean(temp,2),[42,42]); 
% saveHist(conn_power_cop,'spectral-coherence','cooperative','spectcoher_cop');
[target_mat]= plot_strong_ns_top_10_gap(conn_power_cop,0.45,10); 
save_strong_NS(target_mat,0,'cooperative','spectral_coherence_cop_strong'); 
% competition 
temp = horzcat(conn_phase_spectcoher.compet.beta,conn_phase_spectcoher_2.compet);
temp(isnan(temp)) = 0;
conn_power_compet = reshape(mean(temp,2),[42,42]); 
% saveHist(conn_power_compet,'spectral-coherence','competitive','spectcoher_compet')
[target_mat]= plot_strong_ns_top_10_gap(conn_power_compet,0.45,10);
save_strong_NS(target_mat,0,'competitive','spectral_coherence_compet_strong'); 


function [target_mat] = plot_strong_ns_top_10_gap(target_mat,threshold,topN)
% trheshold applied into intra-brin NS 
% topN aplied into inter-brain NS
    INS_mat = target_mat(1:21,22:42); 
    Ms = sort(INS_mat(:),'descend');       
    % result = Ms(1:ceil(length(Ms)*0.1)); 
    result = Ms(1:topN);
    result = result(end,:);
    INS_mat(INS_mat < result) =0 ;
    target_mat(target_mat < threshold) = 0; % intra-brain NS
    target_mat(1:21,22:42) = INS_mat; % ins 
    target_mat(22:42,1:21) = INS_mat';

end
function saveHist(target_mat, corr_type, gameType,title_name)
f = figure('visible','off');
intra_ns_1 = target_mat(1:21,1:21);
intra_ns_2 = target_mat(22:42,22:42);
intra_ns_1(intra_ns_1 == 1) = [];
intra_ns_2(intra_ns_2 == 1) = [];
histogram(horzcat(intra_ns_1,intra_ns_2),1000);
title(['hostrogram of ',corr_type,'-based ',gameType,' intra-brain NS']);
xlabel(corr_type); ylabel('count');
saveas(f,strcat('pic_2\hist_',title_name,'_intra.png'));

h = figure('visible','off');
histogram(target_mat([1:21],[22:42]),1000);
title(['hostrogram of ',corr_type,'-based ',gameType,' inter-brain NS']);
xlabel(corr_type); ylabel('count');
saveas(h,strcat('pic_2\hist_',title_name,'_inter.png'));

end

function save_strong_NS(conn_power,trialI,titleName,saveName)
    conn_power = adjacet_mat(conn_power);
    corr_mat = conn_power;
    EEG_stand = pop_loadset('removeA1A2.set','data/');
    EEG_stand2 = EEG_stand;
    for chanI = 1:21
        EEG_stand2.chanlocs(chanI).labels = strcat(EEG_stand.chanlocs(chanI).labels ,'_2');
     end
    EEG_stand.chanlocs  = [EEG_stand.chanlocs EEG_stand2.chanlocs];

    nch = 21;             
    aij = corr_mat;
    ijw = adj2edgeL(aij);             
    h = figure('visible','off');
    topoplot3(nch, ijw, 'w_wn2wx',0);
%     title(strcat('topograph of power-based team brain network on ',titleName,'game')); % change cooperational into cooperational
    saveas(h,strcat('pic_2/topo_',saveName,'_',num2str(trialI),'.png'));
end


