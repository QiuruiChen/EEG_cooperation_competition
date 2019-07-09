% %%  combined all connectivity between electrodes 
% clear all; close all; clc;
% %% get power connectivity 
% % chanNames = {'FP1','FPz','FP2','F7','F3','Fz','F4','F8','A1','T7','C3','Cz',
% % 'C4','T8','A2','P7','P3','Pz','P4','P8','O1','Oz','O2'};
% comSet = {'compet1','compet2','compet3','compet4','compet5','compet6'...
%     'compet7','compet8','compet9','compet10','compet11','compet12','compet13',...
%     'compet14','compet15','compet16','compet17','compet18','compet19',...
%     'compet20','compet21','compet22'};
% copSet ={'cooperation1','cooperation2','cooperation3',...
%     'cooperation4','cooperation5','cooperation6','cooperation7','cooperation8','cooperation9',...
%     'cooperation10','cooperation11','cooperation12','cooperation13', 'cooperation14','cooperation15',...
%     'cooperation16','cooperation17','cooperation18','cooperation19','cooperation20','cooperation21'...
%     ,'cooperation22','cooperation23','cooperation24','cooperation25'};
% 
% for dicI = 1:length(comSet)
%     conn_temp = load(strcat('data/useful/conn/conn_power_',comSet{dicI},'.mat'),'corr_power');
%     conn_temp = conn_temp.corr_power.corr_beta;
%     conn_temp(:,9) = []; conn_temp(9,:) = []; conn_temp(:,14)=[]; conn_temp(14,:)=[];
%     conn_temp(:,9+21) = []; conn_temp(9+21,:) = []; conn_temp(:,14+20)=[]; conn_temp(14+20,:)=[];
%     conn_power.compet.beta(:,dicI) = conn_temp(:);
% end
% 
% for dicI = 1:length(copSet)
%     conn_temp = load(strcat('data/useful/conn/conn_power_',copSet{dicI},'.mat'),'corr_power');
%     conn_temp = conn_temp.corr_power.corr_beta;
%     conn_temp(:,9) = []; conn_temp(9,:) = []; conn_temp(:,14)=[]; conn_temp(14,:)=[];
%     conn_temp(:,9+21) = []; conn_temp(9+21,:) = []; conn_temp(:,14+20)=[]; conn_temp(14+20,:)=[];
%     conn_power.cop.beta(:,dicI) = conn_temp(:);
% end
% save data/useful/conn/conn_power conn_power 
% %%
% phaseSet = {'spectcoher','ispc','pli'};
% varNamelist = {'conn_phase_spectcoher','conn_phase_ispc','conn_phase_pli'};
% 
% conn_phase_spectcoher = {};
% [conn_phase_spectcoher] = phase_combine(comSet,copSet,'spectcoher',conn_phase_spectcoher);
% save data/useful/conn/conn_phase_spectcoher conn_phase_spectcoher 
% 
% conn_phase_ispc = {};
% [conn_phase_ispc] = phase_combine(comSet,copSet,'ispc',conn_phase_ispc);
% save data/useful/conn/conn_phase_ispc conn_phase_ispc
% 
% conn_phase_pli = {};
% [conn_phase_pli] = phase_combine(comSet,copSet,'pli',conn_phase_pli);
% save data/useful/conn/conn_phase_pli conn_phase_pli 
% %% mutual information are combined in conn_cal.m
% %%  shuffle player A and B in average-time&frequency combined data 
% load('data/useful/conn/conn_power','conn_power');
% [~,trialNumCop] = size(conn_power.cop.beta);
% cop_temp = reshape(conn_power.cop.beta,[42,42,trialNumCop]);
% [~,trialNumCompet] = size(conn_power.compet.beta);
% compet_temp = reshape(conn_power.compet.beta,[42,42,trialNumCompet]);
% [cop,compet] = shuffleIntra(trialNumCop,trialNumCompet,cop_temp,compet_temp);
% conn_power_2.cop = cop; conn_power_2.compet= compet;
% save('data/useful/conn/conn_power_2','conn_power_2')
% 
% load('data/useful/conn/MI_all','MI_all');
% [~,trialNumCop] = size(MI_all.cop);
% cop_temp = reshape(MI_all.cop,[42,42,trialNumCop]);
% [~,trialNumCompet] = size(MI_all.compet);
% compet_temp = reshape(MI_all.compet,[42,42,trialNumCompet]);
% [cop,compet] = shuffleIntra(trialNumCop,trialNumCompet,cop_temp,compet_temp);
% MI_all_2.cop = cop; MI_all_2.compet= compet;
% save('data/useful/conn/MI_all_2','MI_all_2')
% 
% 
% load('data/useful/conn/conn_phase_ispc','conn_phase_ispc');
% [~,trialNumCop] = size(conn_phase_ispc.cop.beta);
% cop_temp = reshape(conn_phase_ispc.cop.beta,[42,42,trialNumCop]);
% [~,trialNumCompet] = size(conn_phase_ispc.compet.beta);
% compet_temp = reshape(conn_phase_ispc.compet.beta,[42,42,trialNumCompet]);
% [cop,compet] = shuffleIntra(trialNumCop,trialNumCompet,cop_temp,compet_temp);
% conn_phase_ispc_2.cop = cop; conn_phase_ispc_2.compet= compet;
% save('data/useful/conn/conn_phase_ispc_2','conn_phase_ispc_2')
% 
% 
% load('data/useful/conn/conn_phase_pli','conn_phase_pli');
% [~,trialNumCop] = size(conn_phase_pli.cop.beta);
% cop_temp = reshape(conn_phase_pli.cop.beta,[42,42,trialNumCop]);
% [~,trialNumCompet] = size(conn_phase_pli.compet.beta);
% compet_temp = reshape(conn_phase_pli.compet.beta,[42,42,trialNumCompet]);
% [cop,compet] = shuffleIntra(trialNumCop,trialNumCompet,cop_temp,compet_temp);
% conn_phase_pli_2.cop = cop; conn_phase_pli_2.compet= compet;
% save('data/useful/conn/conn_phase_pli_2','conn_phase_pli_2')
% 
% load('data/useful/conn/conn_phase_spectcoher','conn_phase_spectcoher');
% [~,trialNumCop] = size(conn_phase_spectcoher.cop.beta);
% cop_temp = reshape(conn_phase_spectcoher.cop.beta,[42,42,trialNumCop]);
% [~,trialNumCompet] = size(conn_phase_spectcoher.compet.beta);
% compet_temp = reshape(conn_phase_spectcoher.compet.beta,[42,42,trialNumCompet]);
% [cop,compet] = shuffleIntra(trialNumCop,trialNumCompet,cop_temp,compet_temp);
% conn_phase_spectcoher_2.cop = cop; conn_phase_spectcoher_2.compet= compet;
% save('data/useful/conn/conn_phase_spectcoher_2','conn_phase_spectcoher_2')

%% combine over-frequncy/time trial

% comSet = {'compet1','compet2','compet3','compet4', 'compet5','compet6','compet7',...
%     'compet8','compet9','compet11','compet12','compet13',...
%     'compet14','compet15','compet16','compet17','compet18','compet19',...
%     'compet20','compet21','compet22'};
% copSet ={'cooperation1','cooperation2','cooperation3','cooperation4','cooperation5','cooperation6','cooperation7','cooperation8','cooperation9',...
%     'cooperation10','cooperation11','cooperation12','cooperation13', 'cooperation14','cooperation15',...
%     'cooperation16','cooperation17','cooperation18','cooperation19','cooperation20','cooperation21'...
%     ,'cooperation22','cooperation23','cooperation24','cooperation25'};

% phase
% conn_phase_over_freq = {};
% [conn_phase_over_freq] = savePhase(comSet,copSet,conn_phase_over_freq,2); %frequency
% save data/useful/conn/conn_phase_over_freq conn_phase_over_freq

% conn_phase_over_time = {};
% [conn_phase_over_time] = savePhase(comSet,copSet,conn_phase_over_time,1); % time
% save data/useful/conn/conn_phase_over_time conn_phase_over_time

% power over time/frequency 
% clear all; close all; clc;
comSet = {'compet1','compet2','compet3','compet4', 'compet5','compet6','compet7',...
    'compet8','compet9','compet10','compet11','compet12','compet13',...
    'compet14','compet15','compet16','compet17','compet18','compet19',...
    'compet20','compet21','compet22'};
copSet ={'cooperation1','cooperation2','cooperation3','cooperation4','cooperation5','cooperation6','cooperation7','cooperation8','cooperation9',...
    'cooperation10','cooperation11','cooperation12','cooperation13', 'cooperation14','cooperation15',...
    'cooperation16','cooperation17','cooperation18','cooperation19','cooperation20','cooperation21'...
    ,'cooperation22','cooperation23','cooperation24','cooperation25'};
% conn_power_over_freq = {};
% [conn_power_over_freq] = savePower(conn_power_over_freq,comSet,copSet,2); % frequency 
% save data/useful/conn/conn_power_over_freq conn_power_over_freq
% 
conn_power_over_time = {};
[conn_power_over_time] = savePower(conn_power_over_time,comSet,copSet,1); % time
save data/useful/conn/conn_power_over_time conn_power_over_time 


function [saveName] = phase_combine(comSet,copSet,phaseType,saveName)
    for dicI = 1:length(comSet)
        conn_temp = load(strcat('data/useful/conn/conn_phase_',comSet{dicI},'.mat'),'corr_phase');
        conn_temp = conn_temp.corr_phase.(phaseType);
        conn_temp(:,9) = []; conn_temp(9,:) = []; conn_temp(:,14)=[]; conn_temp(14,:)=[];
        conn_temp(:,9+21) = []; conn_temp(9+21,:) = []; conn_temp(:,14+20)=[]; conn_temp(14+20,:)=[];
        saveName.compet.beta(:,dicI) = conn_temp(:);
    end

    for dicI = 1:length(copSet) 
        conn_temp = load(strcat('data/useful/conn/conn_phase_',copSet{dicI},'.mat'),'corr_phase');
        conn_temp = conn_temp.corr_phase.(phaseType);
        conn_temp(:,9) = []; conn_temp(9,:) = []; conn_temp(:,14)=[]; conn_temp(14,:)=[];
        conn_temp(:,9+21) = []; conn_temp(9+21,:) = []; conn_temp(:,14+20)=[]; conn_temp(14+20,:)=[];
        saveName.cop.beta(:,dicI) = conn_temp(:);
    end
end

function [cop,compet] = shuffleIntra(trialNumCop,trialNumCompet,cop_temp,compet_temp)
    for copI = 1:trialNumCop
        if copI == 1
            cop = transfer_A_B(cop_temp(:,:,copI));
        else 
            cop(:,copI) = transfer_A_B(cop_temp(:,:,copI));
        end
    end
    for competI = 1:trialNumCompet
        if competI == 1
            compet = transfer_A_B(compet_temp(:,:,competI));
        else 
            compet(:,competI) = transfer_A_B(compet_temp(:,:,competI));
        end
    end
end

function [cop] = transfer_A_B(cop_temp)
    cop = zeros(42,42);
    cop(1:21,1:21) = cop_temp(22:42,22:42);
    cop(22:42,22:42) = cop_temp(1:21,1:21);
    cop(1:21,22:42) = cop_temp(1:21,22:42)';
    cop(22:42,1:21) = cop_temp(22:42,1:21)';
    cop = cop(:);
end
function [conn_power] = savePower(conn_power,comSet,copSet,TimeOrFreq)
    conn_power.compet = cell(42,42);
    for dicI = 1:length(comSet)
        if TimeOrFreq == 1
           conn_temp = load(strcat('data/useful/conn/conn_power_',comSet{dicI},'_overTime.mat'),'corr_power_over_freq');
        elseif TimeOrFreq ==2
           conn_temp = load(strcat('data/useful/conn/conn_power_',comSet{dicI},'_overFreq.mat'),'corr_power_over_freq');
        else
            error("TimeOrFreq can only be 1 or 2");
        end
        conn_temp = conn_temp.corr_power_over_freq.corr_beta;
        if (size(conn_temp{1,1},1) == 1409 || size(conn_temp{1,1},1) == 60)
            conn_temp(:,9) = []; conn_temp(9,:) = []; conn_temp(:,14)=[]; conn_temp(14,:)=[];
            conn_temp(:,9+21) = []; conn_temp(9+21,:) = []; conn_temp(:,14+20)=[]; conn_temp(14+20,:)=[];
            [conn_power.compet] = combineTrails(conn_power.compet ,conn_temp);
        end
    end
    conn_power.cop = cell(42,42);
    for dicI = 1:length(copSet)
        if TimeOrFreq == 1
           conn_temp = load(strcat('data/useful/conn/conn_power_',copSet{dicI},'_overTime.mat'),'corr_power_over_freq');
        elseif TimeOrFreq ==2
           conn_temp = load(strcat('data/useful/conn/conn_power_',copSet{dicI},'_overFreq.mat'),'corr_power_over_freq');
        else
            error("TimeOrFreq can only be 1 or 2");
        end
         conn_temp = conn_temp.corr_power_over_freq.corr_beta;
        if (size(conn_temp{1,1},1) == 1409 || size(conn_temp{1,1},1) == 60)
            conn_temp(:,9) = []; conn_temp(9,:) = []; conn_temp(:,14)=[]; conn_temp(14,:)=[];
            conn_temp(:,9+21) = []; conn_temp(9+21,:) = []; conn_temp(:,14+20)=[]; conn_temp(14+20,:)=[];
            [conn_power.cop] = combineTrails(conn_power.cop ,conn_temp);
        end
    end
end


function [conn_phase] = savePhase(comSet,copSet,conn_phase,TimeOrFreq)
    conn_phase.ispc.compet = cell(42,42);
        for dicI = 1:length(comSet)
            if TimeOrFreq == 1 %time
                conn_temp = load(strcat('data/useful/conn/conn_phase_',comSet{dicI},'_overTime.mat'),'corr_phase_over_time');
                conn_temp = conn_temp.corr_phase_over_time.ispc;
            elseif TimeOrFreq == 2  % frequency 
                conn_temp = load(strcat('data/useful/conn/conn_phase_',comSet{dicI},'_overFreq.mat'),'corr_phase_over_freq');
                conn_temp = conn_temp.corr_phase_over_freq.ispc;
            else 
                error("TimeOrFreq can only be 1 or 2");
            end        
            if (size(conn_temp{1,1},2) == 60)
                conn_temp(:,9) = []; conn_temp(9,:) = []; conn_temp(:,14)=[]; conn_temp(14,:)=[];
                conn_temp(:,9+21) = []; conn_temp(9+21,:) = []; conn_temp(:,14+20)=[]; conn_temp(14+20,:)=[];
                for electrodeI = 1:42
                    for electrodeII = 1:42
                        conn_temp{electrodeI,electrodeII} = conn_temp{electrodeI,electrodeII}';
                    end
                end
                [conn_phase.ispc.compet ] = combineTrails(conn_phase.ispc.compet,conn_temp);
            elseif (size(conn_temp{1,1},1) == 60 || size(conn_temp{1,1},1) == 1409)
                conn_temp(:,9) = []; conn_temp(9,:) = []; conn_temp(:,14)=[]; conn_temp(14,:)=[];
                conn_temp(:,9+21) = []; conn_temp(9+21,:) = []; conn_temp(:,14+20)=[]; conn_temp(14+20,:)=[];
                [conn_phase.ispc.compet ] = combineTrails(conn_phase.ispc.compet,conn_temp);
            end
        end
    conn_phase.ispc.cop = cell(42,42);
    for dicI = 1:length(copSet) 
        if TimeOrFreq == 1 %time
            conn_temp = load(strcat('data/useful/conn/conn_phase_',copSet{dicI},'_overTime.mat'),'corr_phase_over_time');
            conn_temp = conn_temp.corr_phase_over_time.ispc;
        elseif TimeOrFreq == 2  % frequency 
            conn_temp = load(strcat('data/useful/conn/conn_phase_',copSet{dicI},'_overFreq.mat'),'corr_phase_over_freq');
            conn_temp = conn_temp.corr_phase_over_freq.ispc;
        else 
            error("TimeOrFreq can only be 1 or 2");
        end
        
        if (size(conn_temp{1,1},2) == 60)
            conn_temp(:,9) = []; conn_temp(9,:) = []; conn_temp(:,14)=[]; conn_temp(14,:)=[];
            conn_temp(:,9+21) = []; conn_temp(9+21,:) = []; conn_temp(:,14+20)=[]; conn_temp(14+20,:)=[];
            for electrodeI = 1:42
                for electrodeII = 1:42
                    conn_temp{electrodeI,electrodeII} = conn_temp{electrodeI,electrodeII}';
                end
            end
        [conn_phase.ispc.cop] = combineTrails(conn_phase.ispc.cop,conn_temp);
        elseif  (size(conn_temp{1,1},1) == 60 || size(conn_temp{1,1},1) == 1409)
            conn_temp(:,9) = []; conn_temp(9,:) = []; conn_temp(:,14)=[]; conn_temp(14,:)=[];
            conn_temp(:,9+21) = []; conn_temp(9+21,:) = []; conn_temp(:,14+20)=[]; conn_temp(14+20,:)=[];
            [conn_phase.ispc.cop] = combineTrails(conn_phase.ispc.cop,conn_temp);
        end
    end
end
function [aim_cells] = combineTrails(aim_cells,conn_temp)
 for electrodeI = 1:42
        for electrodeII = 1:42
            if isempty(aim_cells{electrodeI,electrodeII})
                aim_cells{electrodeI,electrodeII} = conn_temp{electrodeI,electrodeII};
            else
                aim_cells{electrodeI,electrodeII} = horzcat(aim_cells{electrodeI,electrodeII},...
                    conn_temp{electrodeI,electrodeII});
            end
        end
 end  
end



