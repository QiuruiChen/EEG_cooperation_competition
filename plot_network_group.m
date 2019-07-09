%% plot strong NS
% threshold is one std+ median of intra- and inter-brain NS
clear all; close all; clc;
addpath('f_PlotEEG_BrainNetwork');
addpath('D:\software\eeglab14_1_2b');
%% plot strong NS individually
load('data/useful/conn/conn_phase_spectcoher','conn_phase_spectcoher');
load('data/useful/conn/conn_phase_spectcoher_2','conn_phase_spectcoher_2');
% plot individually
% [~, trialNumCop] = size(conn_phase_spectcoher.cop.beta);
% [~, trialNumCompet] = size(conn_phase_spectcoher.compet.beta);
% for trialI = 1:trialNumCop    
%     conn_spectcoher_cop = reshape(conn_phase_spectcoher.cop.beta(:,trialI),[42,42]);
%     save_strong_NS(conn_spectcoher_cop,trialI,'cooperational','cop')    
% end
% for trialI = 1:trialNumCompet    
%     conn_spectcoher_compet = reshape(conn_phase_spectcoher.compet.beta(:,trialI),[42,42]);
%     save_strong_NS(conn_spectcoher_compet,trialI,'competitive','compet')     
% end

%% plot average over all trials
temp = horzcat(conn_phase_spectcoher.cop.beta,conn_phase_spectcoher_2.cop);
temp(isnan(temp)) = 0;
conn_spectcoher_cop = reshape(mean(temp,2),[42,42]);
save_strong_NS(conn_spectcoher_cop,0,'spectcoher','cop')    

temp = horzcat(conn_phase_spectcoher.compet.beta,conn_phase_spectcoher_2.compet);
temp(isnan(temp)) = 0;
conn_spectcoher_compet = reshape(mean(temp,2),[42,42]);
save_strong_NS(conn_spectcoher_compet,0,'spectcoher','compet')     

% pli
clear all; close all; clc;
load('data/useful/conn/conn_phase_pli','conn_phase_pli');
load('data/useful/conn/conn_phase_pli_2','conn_phase_pli_2');
temp = horzcat(conn_phase_pli.cop.beta,conn_phase_pli_2.cop);
temp(isnan(temp)) = 0; conn_pli_cop = reshape(mean(temp,2),[42,42]);
save_strong_NS(conn_pli_cop,0,'pli','cop')    
temp = horzcat(conn_phase_pli.compet.beta,conn_phase_pli_2.compet);
temp(isnan(temp)) = 0; conn_pli_compet = reshape(mean(temp,2),[42,42]);
save_strong_NS(conn_pli_compet,0,'pli','compet') 


% ispc
clear all; close all; clc;
load('data/useful/conn/conn_phase_ispc','conn_phase_ispc');
load('data/useful/conn/conn_phase_ispc_2','conn_phase_ispc_2');
temp = horzcat(conn_phase_ispc.cop.beta,conn_phase_ispc_2.cop);
temp(isnan(temp)) = 0; conn_ispc_cop = reshape(mean(temp,2),[42,42]);
save_strong_NS(conn_ispc_cop,0,'ispc','cop')    
temp = horzcat(conn_phase_ispc.compet.beta,conn_phase_ispc_2.compet);
temp(isnan(temp)) = 0; conn_ispc_compet = reshape(mean(temp,2),[42,42]);
save_strong_NS(conn_ispc_compet,0,'ispc','compet')     

%power
clear all; close all; clc;
load('data/useful/conn/conn_power','conn_power');
load('data/useful/conn/conn_power_2','conn_power_2');
temp = horzcat(conn_power.cop.beta,conn_power_2.cop);
temp(isnan(temp)) = 0; conn_power_cop = reshape(mean(temp,2),[42,42]);
save_strong_NS(conn_power_cop,0,'power','cop')    
temp = horzcat(conn_power.compet.beta,conn_power_2.compet);
temp(isnan(temp)) = 0; conn_power_compet = reshape(mean(temp,2),[42,42]);
save_strong_NS(conn_power_compet,0,'power','compet')     

%MI
clear all; close all; clc;
load('data/useful/conn/MI_all','MI_all');
load('data/useful/conn/MI_all_2','MI_all_2');
temp = horzcat(MI_all.cop,MI_all_2.cop);
temp(isnan(temp)) = 0; conn_MI_cop = reshape(mean(temp,2),[42,42]);
save_strong_NS(conn_MI_cop,0,'MI','cop');    
temp = horzcat(MI_all.compet,MI_all_2.compet);
temp(isnan(temp)) = 0;conn_MI_compet = reshape(mean(temp,2),[42,42]);
save_strong_NS(conn_MI_compet,0,'MI','compet');     


function save_strong_NS(conn_spectcoher,trialI,typeName,saveName)
    conn_spectcoher = adjacet_mat(conn_spectcoher);
    temp = conn_spectcoher;
    [corr_mat] = remove_outliers(temp);
    % corr_mat(corr_mat>0) = 1;  
    % try  to find the common significant lines over all trails: fail
    EEG_stand = pop_loadset('removeA1A2.set','data/');
    EEG_stand2 = EEG_stand;
    for chanI = 1:21
        EEG_stand2.chanlocs(chanI).labels = strcat(EEG_stand.chanlocs(chanI).labels ,'_2');
     end
    EEG_stand.chanlocs  = [EEG_stand.chanlocs EEG_stand2.chanlocs];
    % adjacency matrix
    if ~(nnz(corr_mat) == 0)% if corr_mat is not null
        % plot intra-brain NS
        clear f;
        f = figure('visible','off');
        imagesc(corr_mat(1:21,1:21));
        set(gca,'xtick',1:1:EEG_stand.nbchan,'xticklabel',{EEG_stand.chanlocs(1:1:21).labels},...
            'ytick',1:1:EEG_stand.nbchan,'yticklabel',{EEG_stand.chanlocs(1:1:21).labels},'fontsize',10);
%         title(strcat('adjacent matrix of spectcoher-correlation-based intra-brain network on ',titleName,' game')); % change cooperational into cooperational
        xtickangle(90);
        axis square;
        colorbar;caxis([0 1]);
        saveas(f,strcat('pic_2/affMatrix_intra_',typeName,'_',saveName,'_',num2str(trialI),'.png'));
        % plot INS
        clear f;
        f = figure('visible','off');
        imagesc(corr_mat(1:21,22:42));
        set(gca,'xtick',1:1:EEG_stand.nbchan,'xticklabel',{EEG_stand.chanlocs(1:1:21).labels},...
            'ytick',1:1:EEG_stand.nbchan,'yticklabel',{EEG_stand.chanlocs(22:1:end).labels},'fontsize',10);
%         title(strcat('adjacent matrix of spectcoher-correlation-based INS brain network on ',titleName,' game')); % change cooperational into cooperational
        xtickangle(90);
        axis square
        colorbar;
        caxis([0 1]);
        saveas(f,strcat('pic_2/affMatrix_inter_',typeName,'_',saveName,'_',num2str(trialI),'.png'));
    end
    % brain maps
    nch = 21;             
    aij = corr_mat;
    ijw = adj2edgeL(aij);             
    h = figure('visible','off');
    topoplot3(nch, ijw, 'w_wn2wx',0);
%     title(strcat('topograph of spectcoher-based team brain network on ',titleName,'game')); % change cooperational into cooperational
    saveas(h,strcat('pic_2/topo_',typeName,'_',saveName,'_',num2str(trialI),'.png'));
end

function [corr_mat] = remove_outliers(temp)
    % remove functional connectivity outliers based on the frist, secon and
    % interpersonal synchrony
    % the first person; INS; the second person
    conn_one = temp(1:21,1:21); conn_both = temp(1:21,22:42);  conn_two = temp(22:42,22:42); 
    % threshold: one std + median  of nonoutlier data
    corr_thresh_1 = std( rmoutliers(conn_one(:)))+median( rmoutliers(conn_one(:)));
    corr_thresh_2 = std( rmoutliers(conn_two(:)))+median( rmoutliers(conn_two(:)));
    corr_thresh_12 = std( rmoutliers(conn_both(:)))+median( rmoutliers(conn_both(:)));
    % threhsold the matrix
    fill_outlier_zero_1 = reshape(filloutliers(conn_one(:),0),[21,21]);
    fill_outlier_zero_2 = reshape(filloutliers(conn_two(:),0),[21,21]);
    fill_outlier_zero_12 = reshape(filloutliers(conn_both(:),0),[21,21]);
    fill_outlier_zero_1(fill_outlier_zero_1<corr_thresh_1)=0;
    fill_outlier_zero_2(fill_outlier_zero_2<corr_thresh_2)=0;
    fill_outlier_zero_12(fill_outlier_zero_12<corr_thresh_12)=0;
    % concate into team brain 
    corr_mat = zeros(42,42); corr_mat(1:21,1:21) = fill_outlier_zero_1;
    corr_mat(22:42,1:21) = fill_outlier_zero_12'; corr_mat(1:21,22:42) = fill_outlier_zero_12;
    corr_mat(22:42,22:42) = fill_outlier_zero_2;
end
% %% plot granger casualaity
% load('data/useful/conn/GCC_all','GCC_all');
% conn_GCC = reshape(mean(GCC_all.compet,2),[20,20]); % change compet into compet
% conn_GCC = conn_GCC - diag(diag(conn_GCC)); % set diagonal into zero 
% % threshold is one std above median connectivity value
% corr_thresh = std(conn_GCC)+median(conn_GCC);
% corr_mat = conn_GCC;
% corr_mat(corr_mat<corr_thresh)=0;
% EEG_stand = pop_loadset('GCC_ROI.set','data/');
% EEG_stand2 = EEG_stand;
% for chanI = 1:10 % ROI is FP1,Fpz,Fp2,F7,F3,F4,F8,C3,Cz,C4
%     EEG_stand2.chanlocs(chanI).labels = strcat(EEG_stand.chanlocs(chanI).labels ,'_2');
%  end
% EEG_stand.chanlocs  = [EEG_stand.chanlocs EEG_stand2.chanlocs];
% % if ~(nnz(corr_mat) == 0) % if corr_mat is not null
% %     clear f;
% %     f = figure('visible','off');
% %     imagesc(corr_mat);
% %     set(gca,'xtick',1:1:2*EEG_stand.nbchan,'xticklabel',{EEG_stand.chanlocs(1:1:end).labels},...
% %         'ytick',1:1:2*EEG_stand.nbchan,'yticklabel',{EEG_stand.chanlocs(1:1:end).labels},'fontsize',6);
% %     xtickangle(90);
% %     xlabel('From'); ylabel('To');
% %     title('affinity matrix of inter-brain GCC on competitive game', 'FontSize', 12); % change cooperational into competitive
% %     axis square
% %     colorbar
% %     saveas(f,'pic/affMatrix_GCC_compet.png');
% % end
% nch = 21;             
% aij = corr_mat;
% ijw = adj2edgeL(aij);  % arrow from the frist column into the second column
% ijw =  horzcat(fliplr(ijw(:,1:2)),ijw(:,3)); % swap ijw the frist and the second column
% % remap Fp1,Fpz,Fp2,F7,F3,F4,F8,C3,Cz,C4  into 1-21(1-10), and 21-42(11-20)
% % change 1-10: Fp1,Fpz,Fp2,F7,F3,F4,F8,C3,Cz,C4 into the right index of 21 electrodes
% ijw(ijw == 20) = 33;ijw(ijw == 19) = 32;ijw(ijw == 18) = 31;ijw(ijw == 17) = 29;
% ijw(ijw == 16) = 28;ijw(ijw == 15) = 26;ijw(ijw == 14) = 25;ijw(ijw == 13) = 24;
% ijw(ijw == 12) = 23;ijw(ijw == 11) = 22;ijw(ijw == 10) = 12;ijw(ijw == 9) = 11;
% ijw(ijw == 8) = 10;  ijw(ijw == 7) = 8;ijw(ijw == 6) = 7; 
% h = figure('visible','off');
% topoplot3(nch, ijw, 'w_wn2wx',1);
% title('topographic map of competitive interaction based on GCC syn')
% saveas(h,'pic/topo_GCC_compet.png');