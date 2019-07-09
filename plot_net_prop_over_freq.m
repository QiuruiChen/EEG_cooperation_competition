clear all; close all; clc;
addpath('D:\work\eeg\Final\last15s\2019_03_03_BCT');
addpath('D:\work\eeg\Final\last15s\SmallWorldNess-master');
addpath('D:\software\eeglab14_1_2b');
% over freqency: power-correlation
% load data/useful/conn/conn_power_over_freq conn_power_over_freq 
% GE_cal(conn_power_over_freq.compet,'power-correlation','competition',2,2,'GE',1409); % intra-brain network GE, competition
% GE_cal(conn_power_over_freq.cop,'power-correlation','cooperation',2,2,'GE',1409);    % intra-brain network GE, cooperation
% GE_cal(conn_power_over_freq.compet,'power-correlation','competition',1,2,'GE',1409); % team-brain network GE,competitiion
% GE_cal(conn_power_over_freq.cop,'power-correlation','cooperation',1,2,'GE',1409);    % team-brain network GE,cooperation
% GE_cal(conn_power_over_freq.compet,'power-correlation','competition',2,1,'SWN',1409);% intra-brain network SWN, competition
% GE_cal(conn_power_over_freq.cop,'power-correlation','cooperation',2,1,'SWN',1409);   % inrta-brain network SWN, cooperation
% GE_cal(conn_power_over_freq.compet,'power-correlation','competition',1,1,'SWN',1409);% team-brain network SWN, competition
% GE_cal(conn_power_over_freq.cop,'power-correlation','cooperation',1,1,'SWN',1409);   % team-brain network SWN, cooperation
% over frequency: ispc
% clear all; close all; clc;
% load data/useful/conn/conn_phase_over_freq conn_phase_over_freq 
% GE_cal(conn_phase_over_freq.ispc.compet,'ISPC','competition',2,2,'GE',45);
% GE_cal(conn_phase_over_freq.ispc.cop,'ISPC','cooperation',2,2,'GE',45);
% GE_cal(conn_phase_over_freq.ispc.compet,'ISPC','competition',1,2,'GE',45);
% GE_cal(conn_phase_over_freq.ispc.cop,'ISPC','cooperation',1,2,'GE',45);
% GE_cal(conn_phase_over_freq.ispc.compet,'ISPC','competition',2,1,'SWN',45);
% GE_cal(conn_phase_over_freq.ispc.cop,'ISPC','cooperation',2,1,'SWN',45);   
% GE_cal(conn_phase_over_freq.ispc.compet,'ISPC','competition',1,1,'SWN',45); 
% GE_cal(conn_phase_over_freq.ispc.cop,'ISPC','cooperation',1,1,'SWN',45); 

%%  over time: ispc
% clear all; close all; clc;
load data/useful/conn/conn_phase_over_time conn_phase_over_time 
% GE_cal(conn_phase_over_time.ispc.compet,'ISPC','competition',1,1,'SWN',60);
% GE_cal(conn_phase_over_time.ispc.cop,'ISPC','cooperation',1,1,'SWN',60);
GE_cal(conn_phase_over_time.ispc.compet,'ISPC','competition',2,1,'SWN',60);
GE_cal(conn_phase_over_time.ispc.cop,'ISPC','cooperation',2,1,'SWN',60);
GE_cal(conn_phase_over_time.ispc.compet,'ISPC','competition',1,2,'GE',60);
GE_cal(conn_phase_over_time.ispc.cop,'ISPC','cooperation',1,2,'GE',60);
GE_cal(conn_phase_over_time.ispc.compet,'ISPC','competition',2,2,'GE',60);
GE_cal(conn_phase_over_time.ispc.cop,'ISPC','cooperation',2,2,'GE',60);
% power
load data/useful/conn/conn_power_over_time conn_power_over_time
GE_cal(conn_power_over_time.compet,'power-correlation','competition',1,2,'GE',60);
GE_cal(conn_power_over_time.cop,'power-correlation','cooperation',1,2,'GE',60);
GE_cal(conn_power_over_time.compet,'power-correlation','competition',2,2,'GE',60);
GE_cal(conn_power_over_time.cop,'power-correlation','cooperation',2,2,'GE',60);
GE_cal(conn_power_over_time.compet,'power-correlation','competition',1,1,'SWN',60);
GE_cal(conn_power_over_time.cop,'power-correlation','cooperation',1,1,'SWN',60);
GE_cal(conn_power_over_time.compet,'power-correlation','competition',2,1,'SWN',60);
GE_cal(conn_power_over_time.cop,'power-correlation','cooperation',2,1,'SWN',60);

function GE_cal(target_mat,conn_type,gameType,teamOrIntra,SWNorGE,prop_type,toalNum)
if toalNum == 1409
   for electrodeI = 1:42
    for electrodeII = 1:42
        % 1:0.03:45 ==> 1409 elements, only select 45 elements to calculate
        % frequency
        target_mat{electrodeI, electrodeII} = target_mat{electrodeI, electrodeII}([1:32:1409],:);
    end
   end
   toalNum = 45;
end
    % teamOrIntra: 1: tream ; 2: intra-brain 
    % SWNorGE: 1: SWN; 2:GE
    % prop_type: 'SWN' or 'GE'
    if teamOrIntra == 1 % team-brain
        % GE on median 
        conn_power_median = cell(42,42);
        for electrodeI = 1:42
            for electrodeII = 1:42
               temp =target_mat{electrodeI,electrodeII}; temp(isnan(temp)) = 0;    
               conn_power_median{electrodeI,electrodeII} = median(temp,2);
            end
        end
        freq_median = cell(42,42,toalNum);
        for electrodeI = 1:42
            for electrodeII = 1:42
                disp(['electrodeI' num2str(electrodeI)]);
                disp(['electrodeII' num2str(electrodeII)]);
                for freqI = 1:toalNum
                   temp = conn_power_median{electrodeI,electrodeII};temp(isnan(temp)) = 0;   
                   freq_median{electrodeI,electrodeII,freqI} = temp(freqI,1);
                end
            end
        end
        effi_median = zeros(toalNum,1);
        if SWNorGE == 1 % SWN
            for freqI =1:toalNum
             effi_median(freqI,1) = cal_properties(adjacet_mat(cell2mat(freq_median(:,:,freqI))),1);
            end
        elseif SWNorGE == 2 % GE
            for freqI =1:toalNum
            effi_median(freqI,1) = cal_properties(adjacet_mat(cell2mat(freq_median(:,:,freqI))),2);
            end
        else
            error('SWNorGE can only be 1 or 2');
        end

        % calcualte efficiency for each trail
        [~,trialNum] = size(target_mat{1,1});
        conn_power_trials = cell(42,42,trialNum);
        for electrodeI = 1:42
            for electrodeII = 1:42
               for trialI = 1:trialNum
                   temp = target_mat{electrodeI,electrodeII};temp(isnan(temp)) = 0;   
                   conn_power_trials{electrodeI,electrodeII,trialI} = temp(:,trialI);
               end
             end
        end
        effi_trials = zeros(toalNum,trialNum);
        for trialI =1:trialNum
            freq_trials = cell(42,42,toalNum);
            for electrodeI = 1:42
                for electrodeII = 1:42
                    for freqI = 1:toalNum
                       temp = conn_power_trials{electrodeI,electrodeII,trialI};temp(isnan(temp)) = 0;  
                       freq_trials{electrodeI,electrodeII,freqI} = temp(freqI,1);
                    end
                end
            end

            if SWNorGE == 1 % SWN
                for freqI =1:toalNum
                  effi_trials(freqI,trialI)  = cal_properties(adjacet_mat(cell2mat(freq_trials(:,:,freqI))),1);
                end
            elseif SWNorGE == 2 % GE
                for freqI =1:toalNum
                 effi_trials(freqI,trialI)  = cal_properties(adjacet_mat(cell2mat(freq_trials(:,:,freqI))),2);
                end
            else
                error('SWNorGE can only be 1 or 2');
            end        
        end
        % plot 
        freq_45 = effi_trials;
        if toalNum == 45
            xaxis = 1:0.99:45;
        elseif toalNum == 60
            xaxis = 15/60:15/60:15;
        end
        f = figure('visible','off');
        set(gcf,'units', 'normalized', 'outerposition', [0 0 1 1]);
        
        subplot(2,1,1);
        boxplot(freq_45','Labels',xaxis);
        xtickangle(90);
        if toalNum == 45
            xlabel('Frequency');
        elseif toalNum == 60
            xlabel('Time(s)');
        end
    %     ylim([0.3 0.75]);% sample boxplot with grouping
        title(['boxplot of the ',prop_type,' of ',conn_type,'-based team-brain-network on ',gameType],'fontsize',20);
        ylabel(prop_type);
        set(gca,'FontSize',20);
        subplot(2,1,2);
        plot(xaxis,effi_median);
    %     ylim([0.15 0.25]);
        title(['lineplot of the ',prop_type,' of the median of the ',conn_type,'-based team-brain-network on ',gameType],'fontsize',20);
        ylabel(prop_type);
        set(gca,'FontSize',20);
        if toalNum == 45
            xlabel('Frequency');
        elseif toalNum == 60
            xlabel('Time(s)');
        end
        if toalNum == 45
            saveas(f,strcat('pic_2/freq_',prop_type,'_team_',conn_type,'_',gameType,'.png'));
        elseif toalNum == 60
            saveas(f,strcat('pic_2/time_',prop_type,'_team_',conn_type,'_',gameType,'.png'));
        end


    elseif teamOrIntra == 2  % intra-brain 

        conn_power_median = cell(21,21);
        for electrodeI = 1:21
            for electrodeII = 1:21
                % concate person A and B
               temp = horzcat(target_mat{electrodeI,electrodeII},target_mat{electrodeI+21,electrodeII+21});
               temp(isnan(temp)) = 0;   
               conn_power_median{electrodeI,electrodeII} = median(temp,2);
            end
        end
        freq_median = cell(21,21,toalNum);
        for electrodeI = 1:21
            for electrodeII = 1:21
                for freqI = 1:toalNum
                   temp = conn_power_median{electrodeI,electrodeII};temp(isnan(temp)) = 0;   
                   freq_median{electrodeI,electrodeII,freqI} = temp(freqI,1);
                end
            end
        end
        effi_median = zeros(toalNum,1);

        if SWNorGE == 1 % SWN
            for freqI =1:toalNum
              effi_median(freqI,1) = cal_properties(adjacet_mat(cell2mat(freq_median(:,:,freqI))),1);
            end
        elseif SWNorGE == 2 % GE
            for freqI =1:toalNum
             effi_median(freqI,1)  = cal_properties(adjacet_mat(cell2mat(freq_median(:,:,freqI))),2);
            end
        else
            error('SWNorGE can only be 1 or 2');
        end  

        % GE for each trail
        [~,trialNum] = size(target_mat{1,1});
        conn_power_trials = cell(21,21,trialNum);
        for electrodeI = 1:21
            for electrodeII = 1:21
               for trialI = 1:trialNum*2
                   temp = horzcat(target_mat{electrodeI,electrodeII},target_mat{electrodeI+21,electrodeII+21});
                   temp(isnan(temp)) = 0;   
                   conn_power_trials{electrodeI,electrodeII,trialI} = temp(:,trialI);
               end
             end
        end
        effi_trials = zeros(toalNum,trialNum*2);
        for trialI =1:trialNum*2
            freq_trials = cell(21,21,toalNum);
            for electrodeI = 1:21
                for electrodeII = 1:21
                    for freqI = 1:toalNum
                       temp = conn_power_trials{electrodeI,electrodeII,trialI};temp(isnan(temp)) = 0;   
                       freq_trials{electrodeI,electrodeII,freqI} = temp(freqI,1);
                    end
                end
            end

            if SWNorGE == 1 % SWN
                for freqI =1:toalNum
                  effi_trials(freqI,trialI)  = cal_properties(adjacet_mat(cell2mat(freq_trials(:,:,freqI))),1);
                end
            elseif SWNorGE == 2 % GE
                for freqI =1:toalNum
                 effi_trials(freqI,trialI)  = cal_properties(adjacet_mat(cell2mat(freq_trials(:,:,freqI))),2);
                end
            else
                error('SWNorGE can only be 1 or 2');
            end  
        end
        %
        freq_45 = effi_trials;
        f = figure('visible','off');
        set(gcf,'units', 'normalized', 'outerposition', [0 0 1 1]);
        if toalNum == 45
            xaxis = 1:0.99:45;
        elseif toalNum == 60
            xaxis = 15/60:15/60:15;
        end
        subplot(2,1,1);
        boxplot(freq_45','Labels',xaxis);
        xtickangle(90);
    %     ylim([0.3 0.75]);% sample boxplot with grouping
        title(['boxplot of the ',prop_type,' of ',conn_type,'-based intra-brain-network on ',gameType],'fontsize',20);
        ylabel(prop_type);
         if toalNum == 45
            xlabel('Frequency');
        elseif toalNum == 60
            xlabel('Time(s)');
        end
        set(gca,'FontSize',20);
        subplot(2,1,2);
        plot(xaxis,effi_median);
    %     ylim([0.15 0.25]);
        title(['lineplot of the ',prop_type,' of the median of the ',conn_type,'-based intra-brain-network on ',gameType],'fontsize',20);
        ylabel(prop_type);
        if toalNum == 45
            xlabel('Frequency');
        elseif toalNum == 60
            xlabel('Time(s)');
        end
        set(gca,'FontSize',20);
        if toalNum == 45
           saveas(f,strcat('pic_2/freq_',prop_type,'_intra_',conn_type,'_',gameType,'.png'));
        elseif toalNum == 60
           saveas(f,strcat('pic_2/time_',prop_type,'_intra_',conn_type,'_',gameType,'.png'));
        end
    else
        error('teamOrIntra can only be 1(team-brain) or 2(intra-brain)')
    end
end

function  prop_val = cal_properties(A,SmallOrGE)
    if SmallOrGE == 1

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
        [prop_val,~,~] = small_world_ness(A,expectedL,expectedC,FLAG_Ctransitive);  %  Using transitive clustering coefficient
    elseif SmallOrGE ==2 
        prop_val = efficiency_wei(A);
    else
        error('SmallOrGE can only be 1(SWN) or 2(GE)');
    end
end
