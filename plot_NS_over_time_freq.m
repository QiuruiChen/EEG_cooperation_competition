%% plot inter- and intra-brain connectivity over frequency/time
% over frequency 
% clear all; close all; clc;
% load data/useful/conn/conn_power_over_freq conn_power_over_freq 
% cal_mat = conn_power_over_freq.compet; connection_title = 'power correlation';
% conn_type = 'power'; gameType = 'competition';
% plotPower(cal_mat,connection_title,conn_type,gameType,2); % plot competition
% 
% clear all;close all;clc;
% load data/useful/conn/conn_power_over_freq conn_power_over_freq 
% cal_mat = conn_power_over_freq.cop; connection_title = 'power correlation';
% conn_type = 'power'; gameType = 'cop';
% plotPower(cal_mat,connection_title,conn_type,gameType); % plot competition

clear all; close all; clc;
load data/useful/conn/conn_phase_over_freq conn_phase_over_freq
cal_mat = conn_phase_over_freq.ispc.cop;connection_title = 'ispc';
conn_type = 'ispc'; gameType = 'cop';
plotPower(cal_mat,connection_title,conn_type,gameType,2); % plot competition

clear all; close all; clc;
load data/useful/conn/conn_phase_over_freq conn_phase_over_freq
cal_mat = conn_phase_over_freq.ispc.compet;connection_title = 'ispc';
conn_type = 'ispc'; gameType = 'competition';
plotPower(cal_mat,connection_title,conn_type,gameType,2); % plot competition

%%  over time
% clear all; close all; clc;
% load data/useful/conn/conn_power_over_time conn_power_over_time 
% cal_mat = conn_power_over_time.compet; connection_title = 'power correlation';
% conn_type = 'power'; gameType = 'competition';
% plotPower(cal_mat,connection_title,conn_type,gameType,1); 
% clear all;close all;clc;
% load data/useful/conn/conn_power_over_time conn_power_over_time 
% cal_mat = conn_power_over_time.cop; connection_title = 'power correlation';
% conn_type = 'power'; gameType = 'cop';
% plotPower(cal_mat,connection_title,conn_type,gameType,1); 
% clear all; close all; clc;
% load data/useful/conn/conn_phase_over_time conn_phase_over_time
% cal_mat = conn_phase_over_time.ispc.cop;connection_title = 'ispc';
% conn_type = 'ispc'; gameType = 'cop';
% plotPower(cal_mat,connection_title,conn_type,gameType,1); 
% clear all; close all; clc;
% load data/useful/conn/conn_phase_over_time conn_phase_over_time
% cal_mat = conn_phase_over_time.ispc.compet;connection_title = 'ispc';
% conn_type = 'ispc'; gameType = 'competition';
% plotPower(cal_mat,connection_title,conn_type,gameType,1); 

function plotPower(cal_mat,connection_title,conn_type,gameType,TimeOrFreq)
% TimeOrFreq =1: over time; TimeOrFreq ==2: over frequency 
electrodes = {'FP1','FPz','FP2','F7','F3','Fz','F4','F8','T7','C3','Cz',...
    'C4','T8','P7','P3','Pz','P4','P8','O1','Oz','O2'}; % the first person
electrodes_2 = {'FP1_2','FPz_2','FP2_2','F7_2','F3_2','Fz_2','F4_2','F8_2','T7_2','C3_2','Cz_2',...
    'C4_2','T8_2','P7_2','P3_2','Pz_2','P4_2','P8_2','O1_2','Oz_2','O2_2'}; % the second person
if TimeOrFreq == 1
    xaxis = 0:15/60:(15-15/60);
elseif TimeOrFreq == 2
  for electrodeI = 1:42
    for electrodeII = 1:42 
        % 1:0.03:45 ==> 1409 elements, only select 45 elements to calculate
        % frequency
        cal_mat{electrodeI, electrodeII} = cal_mat{electrodeI, electrodeII}([1:32:1409],:);
    end
  end
  xaxis = 1:45;
else
    error("TimeOrFreq can only be 1 or 2");
end
for electrodeI = 1:42
    for eletctrodeII = electrodeI : 42
       if (electrodeI == 9 && eletctrodeII== 42)
       if electrodeI ~= eletctrodeII
           [~,trials] =  size(cal_mat{electrodeI,eletctrodeII});
           for trialI =1:trials+2
               lengdaLabes{trialI}= strcat('trail',num2str(trialI));
           end
           lengdaLabes{trials+1} = 'mean of all trials';
           lengdaLabes{trials+2} = 'median of all trials';
           f = figure('visible','off');
           colors = hsv(trials);
           temp_data = horzcat(cal_mat{electrodeI,eletctrodeII},mean(cal_mat{electrodeI,eletctrodeII},2),...
               median(cal_mat{electrodeI,eletctrodeII},2));
           h = plot(xaxis,temp_data);
           colors = vertcat(vertcat(colors,[0 0 0]),[0.8571    0.8571    0.8571]);
           set(h, {'color'}, num2cell(colors, 2));
           if TimeOrFreq == 1
               xlim([0 15]); xlabel("Time(s)");
           elseif TimeOrFreq ==2
               xlim([1 45]);xlabel("Frequency(Hz)");
           else 
               error("TimeOrFreq can only be 1 or 2");
           end
           lineWidth = cell(trials+2,1);
           lineWidth{trials+1,1} = 3;  lineWidth{end,1} = 3;
           set(h,{'LineWidth'},lineWidth)
           legend(lengdaLabes,'Location','northeastoutside','FontSize',8);
           if electrodeI > 21
               electrodeI_name = electrodes_2{electrodeI-21};
           else 
               electrodeI_name = electrodes{electrodeI};
           end
           if eletctrodeII > 21
               eletctrodeII_name = electrodes_2{eletctrodeII-21};
           else 
               eletctrodeII_name = electrodes{eletctrodeII};
           end
           title([connection_title,' during ',gameType,' between ',electrodeI_name,' ',eletctrodeII_name]);
           if TimeOrFreq == 1
                saveas(f,strcat('pic_2/time_',conn_type,'_',gameType,'_',electrodeI_name,eletctrodeII_name,'.png'));
           elseif TimeOrFreq ==2
                saveas(f,strcat('pic_2/freq_',conn_type,'_',gameType,'_',electrodeI_name,eletctrodeII_name,'.png'));
           else
               error("TimeOrFreq can only be 1 or 2");
           end
           end
       end
    end
end 
end


