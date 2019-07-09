clear all; close all; clc;
load('data\useful\conn\conn_phase_power.mat', 'conn_phase_power');
% load('data\useful\conn\power_all.mat', 'power_all');
% load('data\useful\conn\conn_power.mat', 'conn_power');
compet_performance =[138;182;159;118;190;250;146;198;188;157;165;191;122;247;359];
cop_performance = [117;116;178;220;200;149;199;151;205;118;130;118;144;186;191;150];
% compet 
temp_compet = conn_phase_power.compet.beta(:,9:23);
temp_compet(isnan(temp_compet)) = 0;
compet_data = reshape(temp_compet,[42,42,15]); % select inter-brain syn 
compet_data = compet_data(1:21,22:42,:);
compet_data = reshape(compet_data,[21*21,15]);
compet_data = mean(compet_data,1)'; 
% cooperation
temp_cop = conn_phase_power.cop.beta(:,9:24);
temp_cop(isnan(temp_cop)) = 0;
cop_data = reshape(temp_cop,[42,42,16]); % select inter-brain syn 
cop_data = cop_data(1:21,22:42,:);
cop_data = reshape(cop_data,[21*21,16]);
cop_data = mean(cop_data,1)';

h = figure('visible','off');
f=fit(compet_performance,compet_data,'poly1'); % poly1: Linear polynomial curve
hL1 = plot(f,compet_performance,compet_data);
hold on;
f=fit(cop_performance,cop_data,'poly1');
hL2 = plot(f,cop_performance,cop_data);
hold off;
ylabel('power') 
xlabel('game duration(s)') 
title('line plot of inter-brain power and game duration');
legend({'competition data','fitted curve for competition',...
    'cooperational data','fitted curve for cooperation',})
set(hL1(2),'color','c');
set(hL1(1),'color','g');
saveas(h,'pic_2/behavior_power.png');

%% relate behavorial data with global efficiency (efficiency_wei(W_nrm))
clear all; close all;clc;
addpath('D:\work\eeg\2personGame\2019_03_03_BCT');
% load('data/useful/conn/conn_phase_power','conn_phase_power');
% load('data/useful/conn/conn_phase_power_2','conn_phase_power_2');
% load('data/useful/conn/power_all','power_all');
% load('data/useful/conn/power_all_2','power_all_2');

load('data/useful/conn/conn_power','conn_power');
load('data/useful/conn/conn_power_2','conn_power_2');

compet_performance =[138;182;159;118;190;250;146;198;188;157;165;191;122;247;359];
cop_performance = [117;116;178;220;200;149;199;151;205;118;130;118;144;186;191;150];

compet_data_temp = conn_power.compet.beta(:,9:23); 
compet_data_temp(:,:,2) = conn_power_2.compet(:,9:23); 
compet_data = mean(compet_data_temp,3);

cop_data_temp = conn_power.compet.beta(:,9:24); 
cop_data_temp(:,:,2) = conn_power_2.compet(:,9:24); 
cop_data = mean(cop_data_temp,3);
for competI = 1:size(compet_data,2) 
    disp(['calculatiing compet trial ',num2str(competI)]);
    W_compet = reshape(compet_data(:,competI),[42,42]); % reshape into 21x21 
    W_compet = adjacet_mat(W_compet);
    compet_list(competI) =efficiency_wei(W_compet);
end
for copI = 1:size(cop_data,2)   
    disp(['calculatiing competitive trial ',num2str(copI)]);
    W_cop = reshape(cop_data(:,copI),[42,42]); % reshape into 21x21
    W_cop = adjacet_mat(W_cop);
    cop_list(copI) =efficiency_wei(W_cop);
end
% plot with behavorial data
compet_data = compet_list';
cop_data = cop_list';
h = figure('visible','off');
f=fit(compet_performance,compet_data,'poly1'); % poly1: Linear polynomial curve
hL1 = plot(f,compet_performance,compet_data);
hold on;
f=fit(cop_performance,cop_data,'poly1');
hL2 = plot(f,cop_performance,cop_data);
hold off; ylabel('global efficiency'); xlabel('game duration(s)'); 
title({'line plot of global efficiency of inter-brain','power-correlation-based network and game duration'});
legend({'competition data','fitted curve for competition',...
    'cooperational data','fitted curve for cooperation',});
set(hL1(2),'color','c');
set(hL1(1),'color','g');
saveas(h,'pic_2/behavior_power_GL.png');


%% plot topographic map of betweeness
addpath('D:\work\eeg\2PersonPongGame\f_PlotEEG_BrainNetwork');
clear all; close all; clc;
load('data/useful/network/prop_cop_spectcoher.mat','prop_cop_spectcoher')
% for cop and cop
temp = horzcat([1:42]',prop_cop_spectcoher.betweenness);
h = figure('visible','off');
topoplotNode(21,temp,'w_wn2wx',1);
title('betweeness of nodes based on spectcoher syn for the cooperational game');
saveas(h,'pic_2/betweeness_spectcoher_cop.png');
