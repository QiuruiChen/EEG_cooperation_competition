% This file preprocesses the gdf file 
% Save eacg competition and cooperation session into set file
clear all;clc;close all;
addpath('D:\software\eeglab14_1_2b');
addpath('D:\software\fieldtrip-20190325');
%% trial 11;
% for fileBIOSIG = 1:length(fileNameSet)
%     EEG = pop_biosig(strcat('D:\work\eeg\Final\last15s\',fileNameSet{fileBIOSIG},'.gdf'));
%     EEG = eeg_checkset( EEG );
%     pop_expevents(EEG,strcat('D:\work\eeg\Final\last15s\',fileNameSet{fileBIOSIG},'.csv') , 'samples');
% end
% run trimData.py, get event timepoints
clear all;close all; clc;
fieldTrip_save_path = 'data/trial11/';
variableName = 'compet';
temp_1024_1319 = [32769.0,102680.0;32770.0,429726.0];
temp_8000_1319 = [32769.0,102680.0;32770.0,429726.0];
gdf_1024_1319 = 'D:\work\eeg\Final\last15s\data/trial11/record-[2019.04.25-13.19.38]-1024.gdf';
gdf_8000_1319 = 'D:\work\eeg\Final\last15s\data/trial11/record-[2019.04.25-13.19.35]-8000.gdf';
temp_1024_1323 = [32769.0,38057.0;32770.0,588866.0];
temp_8000_1323 = [32769.0,38057.0;32770.0,588866.0];
gdf_1024_1323 = 'D:\work\eeg\Final\last15s\data/trial11/record-[2019.04.25-13.23.46]-1024.gdf';
gdf_8000_1323 = 'D:\work\eeg\Final\last15s\data/trial11/record-[2019.04.25-13.23.44]-8000.gdf';

cfg            = [];
cfg.dataset    = gdf_1024_1319;
cfg.continuous = 'yes';
cfg.channel    = 'all';
sample_data    = ft_preprocessing(cfg);

data_1024_1319= ft_read_data(gdf_1024_1319);
data_1024_1323= ft_read_data(gdf_1024_1323);
data_8000_1319= ft_read_data(gdf_8000_1319);
data_8000_1323= ft_read_data(gdf_8000_1323);
loopLength = (size(temp_1024_1319,1)+size(temp_1024_1323,1))/2;

col{1,1} = data_1024_1319(:,[temp_1024_1319(1,2):temp_1024_1319(2,2)]);
col{1,2} = data_8000_1319(:,[temp_8000_1319(1,2):temp_8000_1319(2,2)]);
col{2,1} = data_1024_1323(:,[temp_1024_1323(1,2):temp_1024_1323(2,2)]);
col{2,2} = data_8000_1323(:,[temp_8000_1323(1,2):temp_8000_1323(2,2)]);
% save files 
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName)
% cooperation
addpath('D:\software\fieldtrip-20190325');
fieldTrip_save_path = 'data/trial11/';
variableName = 'cooperation';
temp_1024_1334 = [32769.0,47716.0;32770.0,327224.0];
temp_8000_1334 = [32769.0,47716.0;32770.0,327224.0];
gdf_1024_1334 = 'D:\work\eeg\Final\last15s\data/trial11/record-[2019.04.25-13.34.25]-1024.gdf';
gdf_8000_1334 = 'D:\work\eeg\Final\last15s\data/trial11/record-[2019.04.25-13.34.29]-8000.gdf';
temp_1024_1330 = [32769.0,45423.0;32770.0,247082.0];
temp_8000_1330 = [32769.0,45423.0;32770.0,247082.0];
gdf_1024_1330 = 'D:\work\eeg\Final\last15s\data/trial11/record-[2019.04.25-13.30.45]-1024.gdf';
gdf_8000_1330 = 'D:\work\eeg\Final\last15s\data/trial11/record-[2019.04.25-13.30.41]-8000.gdf';
data_1024_1334= ft_read_data(gdf_1024_1334);
data_1024_1330= ft_read_data(gdf_1024_1330);
data_8000_1334= ft_read_data(gdf_8000_1334);
data_8000_1330= ft_read_data(gdf_8000_1330);
% 32769 is start, 32770 is end 
loopLength = (size(temp_1024_1330,1)+size(temp_1024_1334,1))/2;

col{1,1} = data_1024_1334(:,[temp_1024_1334(1,2):temp_1024_1334(2,2)]);
col{1,2} = data_8000_1334(:,[temp_8000_1334(1,2):temp_8000_1334(2,2)]);
col{2,1} = data_1024_1330(:,[temp_1024_1330(1,2):temp_1024_1330(2,2)]);
col{2,2} = data_8000_1330(:,[temp_8000_1330(1,2):temp_8000_1330(2,2)]);
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName)

fileNameSet = {'compet1.set','compet2.set','cooperation1.set','cooperation2.set',};
varSet = {'compet1','compet2','cooperation1','cooperation2'};
pre_process(fileNameSet,fieldTrip_save_path,varSet);
%% trial 10:
fileNameSet = {'data/trial10/record-[2019.04.18-16.43.47]-1024','data/trial10/record-[2019.04.18-16.46.54]-1024',...
'data/trial10/record-[2019.04.18-16.50.48]-1024','data/trial10/record-[2019.04.18-16.58.16]-1024',...
'data/trial10/record-[2019.04.18-17.01.19]-1024','data/trial10/record-[2019.04.18-17.05.33]-1024'};
% for fileBIOSIG = 1:length(fileNameSet)
%     EEG = pop_biosig(strcat('D:\work\eeg\Final\last15s\',fileNameSet{fileBIOSIG},'.gdf'));
%     EEG = eeg_checkset( EEG );
%     pop_expevents(EEG,strcat('D:\work\eeg\Final\last15s\',fileNameSet{fileBIOSIG},'.csv') , 'samples');
% end
% run trimData.py, get event timepoints
fieldTrip_save_path = 'data/trial10/';
variableName = 'cooperation';
temp_1024_1701 = [32769.0,29715.0;32770.0,447426.0];
temp_8000_1701 = [32769.0,29715.0;32770.0,447426.0];
gdf_1024_1701 = 'D:\work\eeg\Final\last15s\data/trial10/record-[2019.04.18-17.01.19]-1024.gdf';
gdf_8000_1701 = 'D:\work\eeg\Final\last15s\data/trial10/record-[2019.04.18-17.01.21]-8000.gdf';
temp_1024_1658 = [32769.0,28252.0;32770.0,355689.0];
temp_8000_1658 = [32769.0,28252.0;32770.0,355689.0];
gdf_1024_1658 = 'D:\work\eeg\Final\last15s\data/trial10/record-[2019.04.18-16.58.16]-1024.gdf';
gdf_8000_1658 = 'D:\work\eeg\Final\last15s\data/trial10/record-[2019.04.18-16.58.18]-8000.gdf';

cfg            = [];
cfg.dataset    = gdf_1024_1701;
cfg.continuous = 'yes';
cfg.channel    = 'all';
sample_data    = ft_preprocessing(cfg);

data_1024_1701= ft_read_data(gdf_1024_1701);
data_1024_1658= ft_read_data(gdf_1024_1658);
data_8000_1701= ft_read_data(gdf_8000_1701);
data_8000_1658= ft_read_data(gdf_8000_1658);
loopLength = (size(temp_1024_1701,1)+size(temp_1024_1658,1))/2;

col{1,1} = data_1024_1701(:,[temp_1024_1701(1,2):temp_1024_1701(2,2)]);
col{1,2} = data_8000_1701(:,[temp_8000_1701(1,2):temp_8000_1701(2,2)]);
col{2,1} = data_1024_1658(:,[temp_1024_1658(1,2):temp_1024_1658(2,2)]);
col{2,2} = data_8000_1658(:,[temp_8000_1658(1,2):temp_8000_1658(2,2)]);
% save files 
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName)
%% cooperation
addpath('D:\software\fieldtrip-20190325');
fieldTrip_save_path = 'data/trial10/';
variableName = 'compet';
temp_1024_1650 = [32769.0,29472.0;32770.0,455064.0];
temp_8000_1650 = [32769.0,29472.0;32770.0,455064.0];
gdf_1024_1650 = 'D:\work\eeg\Final\last15s\data/trial10/record-[2019.04.18-16.50.48]-1024.gdf';
gdf_8000_1650 = 'D:\work\eeg\Final\last15s\data/trial10/record-[2019.04.18-16.50.52]-8000.gdf';
temp_1024_1646 = [32769.0,130873.0;32770.0,460995.0];
temp_8000_1646 = [32769.0,130873.0;32770.0,460995.0];
gdf_1024_1646 = 'D:\work\eeg\Final\last15s\data/trial10/record-[2019.04.18-16.46.54]-1024.gdf';
gdf_8000_1646 = 'D:\work\eeg\Final\last15s\data/trial10/record-[2019.04.18-16.46.58]-8000.gdf';
data_1024_1650= ft_read_data(gdf_1024_1650);
data_1024_1646= ft_read_data(gdf_1024_1646);
data_8000_1650= ft_read_data(gdf_8000_1650);
data_8000_1646= ft_read_data(gdf_8000_1646);
% 32769 is start, 32770 is end 
loopLength = (size(temp_1024_1646,1)+size(temp_1024_1650,1))/2;

col{1,1} = data_1024_1650(:,[temp_1024_1650(1,2):temp_1024_1650(2,2)]);
col{1,2} = data_8000_1650(:,[temp_8000_1650(1,2):temp_8000_1650(2,2)]);
col{2,1} = data_1024_1646(:,[temp_1024_1646(1,2):temp_1024_1646(2,2)]);
col{2,2} = data_8000_1646(:,[temp_8000_1646(1,2):temp_8000_1646(2,2)]);
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName)
%%
fileNameSet = {'compet1.set','compet2.set','cooperation1.set','cooperation2.set',};
varSet = {'compet1','compet2','cooperation1','cooperation2'};
pre_process(fileNameSet,fieldTrip_save_path,varSet);
%% trial 9
% load gdf file, export event 
clear all; close all; clc;
addpath('D:\software\fieldtrip-20190325');
fileNameSet = {'data/trial9/record-[2019.04.17-14.26.48]-1024','data/trial9/record-[2019.04.17-14.31.53]-1024',...
'data/trial9/record-[2019.04.17-14.41.01]-1024','data/trial9/record-[2019.04.17-14.48.49]-1024',...
 'data/trial9/record-[2019.04.17-14.53.27]-1024'};
for fileBIOSIG = 1:length(fileNameSet)
    EEG = pop_biosig(strcat('D:\work\eeg\Final\last15s\',fileNameSet{fileBIOSIG},'.gdf'));
    EEG = eeg_checkset( EEG );
    pop_expevents(EEG,strcat('D:\work\eeg\Final\last15s\',fileNameSet{fileBIOSIG},'.csv') , 'samples');
end
% run trimData.py, get event timepoints
fieldTrip_save_path = 'data/trial9/';
variableName = 'cooperation';
temp_1024_1448 = [32769.0,52739.0;32770.0,449809.0];
temp_8000_1448 = [32769.0,52739.0;32770.0,449809.0];
gdf_1024_1448 = 'D:\work\eeg\Final\last15s\data/trial9/record-[2019.04.17-14.48.49]-1024.gdf';
gdf_8000_1448 = 'D:\work\eeg\Final\last15s\data/trial9/record-[2019.04.17-14.48.53]-8000.gdf';
temp_1024_1441 = [32769.0,23287.0;32770.0,336652.0];
temp_8000_1441 = [32769.0,23287.0;32770.0,336652.0];
gdf_1024_1441 = 'D:\work\eeg\Final\last15s\data/trial9/record-[2019.04.17-14.41.01]-1024.gdf';
gdf_8000_1441 = 'D:\work\eeg\Final\last15s\data/trial9/record-[2019.04.17-14.41.05]-8000.gdf';

cfg            = [];
cfg.dataset    = gdf_1024_1448;
cfg.continuous = 'yes';
cfg.channel    = 'all';
sample_data    = ft_preprocessing(cfg);

data_1024_1448= ft_read_data(gdf_1024_1448);
data_1024_1441= ft_read_data(gdf_1024_1441);
data_8000_1448= ft_read_data(gdf_8000_1448);
data_8000_1441= ft_read_data(gdf_8000_1441);
loopLength = (size(temp_1024_1448,1)+size(temp_1024_1441,1))/2;

col{1,1} = data_1024_1448(:,[temp_1024_1448(1,2):temp_1024_1448(2,2)]);
col{1,2} = data_8000_1448(:,[temp_8000_1448(1,2):temp_8000_1448(2,2)]);
col{2,1} = data_1024_1441(:,[temp_1024_1441(1,2):temp_1024_1441(2,2)]);
col{2,2} = data_8000_1441(:,[temp_8000_1441(1,2):temp_8000_1441(2,2)]);
% save files 
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName)
% cooperation
addpath('D:\software\fieldtrip-20190325');
fieldTrip_save_path = 'data/trial9/';
variableName = 'compet';
temp_1024_1426 = [32769.0,76621.0;32770.0,586678.0];
temp_8000_1426 = [32769.0,76621.0;32770.0,586678.0];
gdf_1024_1426 = 'D:\work\eeg\Final\last15s\data/trial9/record-[2019.04.17-14.26.48]-1024.gdf';
gdf_8000_1426 = 'D:\work\eeg\Final\last15s\data/trial9/record-[2019.04.17-14.26.45]-8000.gdf';
temp_1024_1431 = [32769.0,47488.0;32770.0,788320.0];
temp_8000_1431 = [32769.0,47488.0;32770.0,788320.0];
gdf_1024_1431 = 'D:\work\eeg\Final\last15s\data/trial9/record-[2019.04.17-14.31.53]-1024.gdf';
gdf_8000_1431 = 'D:\work\eeg\Final\last15s\data/trial9/record-[2019.04.17-14.31.57]-8000.gdf';
data_1024_1426= ft_read_data(gdf_1024_1426);
data_1024_1431= ft_read_data(gdf_1024_1431);
data_8000_1426= ft_read_data(gdf_8000_1426);
data_8000_1431= ft_read_data(gdf_8000_1431);
% 32769 is start, 32770 is end 
loopLength = (size(temp_1024_1431,1)+size(temp_1024_1426,1))/2;

col{1,1} = data_1024_1426(:,[temp_1024_1426(1,2):temp_1024_1426(2,2)]);
col{1,2} = data_8000_1426(:,[temp_8000_1426(1,2):temp_8000_1426(2,2)]);
col{2,1} = data_1024_1431(:,[temp_1024_1431(1,2):temp_1024_1431(2,2)]);
col{2,2} = data_8000_1431(:,[temp_8000_1431(1,2):temp_8000_1431(2,2)]);
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName)

fileNameSet = {'compet1.set','compet2.set','cooperation1.set','cooperation2.set',};
varSet = {'compet1','compet2','cooperation1','cooperation2'};
pre_process(fileNameSet,fieldTrip_save_path,varSet);
%% trial8: 2 game rounds
clear all; close all; clc;
addpath('D:\software\fieldtrip-20190325');
fieldTrip_save_path = 'data/trial8/';
variableName = 'compet';
temp_1024_1735 = [32769.0,42256.0;32770.0,295188.0];
temp_8000_1735 = [32769.0,42256.0;32770.0,295188.0];
gdf_1024_1735 = 'D:\work\eeg\Final\last15s\data/trial8/record-[2019.04.15-17.35.19]-1024.gdf';
gdf_8000_1735 = 'D:\work\eeg\Final\last15s\data/trial8/record-[2019.04.15-17.35.22]-8000.gdf';
temp_1024_1731 = [32769.0,54535.0;32770.0,341172.0];
temp_8000_1731 = [32769.0,54535.0;32770.0,341172.0];
gdf_1024_1731 = 'D:\work\eeg\Final\last15s\data/trial8/record-[2019.04.15-17.31.54]-1024.gdf';
gdf_8000_1731 = 'D:\work\eeg\Final\last15s\data/trial8/record-[2019.04.15-17.31.51]-8000.gdf';

cfg            = [];
cfg.dataset    = gdf_1024_1735;
cfg.continuous = 'yes';
cfg.channel    = 'all';
sample_data    = ft_preprocessing(cfg);

data_1024_1735= ft_read_data(gdf_1024_1735);
data_1024_1731= ft_read_data(gdf_1024_1731);
data_8000_1735= ft_read_data(gdf_8000_1735);
data_8000_1731= ft_read_data(gdf_8000_1731);
loopLength = (size(temp_1024_1735,1)+size(temp_1024_1731,1))/2;

col{1,1} = data_1024_1735(:,[temp_1024_1735(1,2):temp_1024_1735(2,2)]);
col{1,2} = data_8000_1735(:,[temp_8000_1735(1,2):temp_8000_1735(2,2)]);
col{2,1} = data_1024_1731(:,[temp_1024_1731(1,2):temp_1024_1731(2,2)]);
col{2,2} = data_8000_1731(:,[temp_8000_1731(1,2):temp_8000_1731(2,2)]);
% save files 
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName)
% cooperation
addpath('D:\software\fieldtrip-20190325');
fieldTrip_save_path = 'data/trial8/';
variableName = 'cooperation';
temp_1024_1726 = [32769.0,39773.0;32770.0,422951.0];
temp_8000_1726 = [32769.0,39773.0;32770.0,422951.0];
gdf_1024_1726 = 'D:\work\eeg\Final\last15s\data/trial8/record-[2019.04.15-17.26.06]-1024.gdf';
gdf_8000_1726 = 'D:\work\eeg\Final\last15s\data/trial8/record-[2019.04.15-17.26.02]-8000.gdf';
temp_1024_1721 = [32769.0,38849.0;32770.0,421374.0];
temp_8000_1721 = [32769.0,38849.0;32770.0,421374.0];
gdf_1024_1721 = 'D:\work\eeg\Final\last15s\data/trial8/record-[2019.04.15-17.21.30]-1024.gdf';
gdf_8000_1721 = 'D:\work\eeg\Final\last15s\data/trial8/record-[2019.04.15-17.21.28]-8000.gdf';

data_1024_1726= ft_read_data(gdf_1024_1726);
data_1024_1721= ft_read_data(gdf_1024_1721);
data_8000_1726= ft_read_data(gdf_8000_1726);
data_8000_1721= ft_read_data(gdf_8000_1721);
loopLength = (size(temp_1024_1721,1)+size(temp_1024_1726,1))/2;

col{1,1} = data_1024_1726(:,[temp_1024_1726(1,2):temp_1024_1726(2,2)]);
col{1,2} = data_8000_1726(:,[temp_8000_1726(1,2):temp_8000_1726(2,2)]);
col{2,1} = data_1024_1721(:,[temp_1024_1721(1,2):temp_1024_1721(2,2)]);
col{2,2} = data_8000_1721(:,[temp_8000_1721(1,2):temp_8000_1721(2,2)]);
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName)

fileNameSet = {'compet1.set','compet2.set','cooperation1.set','cooperation2.set',};
varSet = {'compet1','compet2','cooperation1','cooperation2'};
pre_process(fileNameSet,fieldTrip_save_path,varSet)
%% trial 7 different setting: allow to talk with each other 
clear all; close all; clc;
addpath('D:\software\fieldtrip-20190325');
fieldTrip_save_path = 'data/trial7/';
variableName = 'compet';
temp_1024_1808 = [32769.0,30459.0;32770.0,278646.0;32769.0,319110.0;32770.0,621228.0];
temp_8000_1808 = [32769.0,30459.0;32770.0,278646.0;32769.0,319110.0;32770.0,621228.0];
gdf_1024_1808 = 'D:\work\eeg\Final\last15s\data/trial7/record-[2019.04.12-18.06.27]-1024.gdf';
gdf_8000_1808 = 'D:\work\eeg\Final\last15s\data/trial7/record-[2019.04.12-18.06.29]-8000.gdf';
temp_1024_1800 = [32769.0,24522.0;32770.0,272682.0;32769.0,303504.0;32770.0,574325.0];
temp_8000_1800 = [32769.0,24522.0;32770.0,272682.0;32769.0,303504.0;32770.0,574325.0];
gdf_1024_1800 = 'D:\work\eeg\Final\last15s\data/trial7/record-[2019.04.12-18.00.07]-1024.gdf';
gdf_8000_1800 = 'D:\work\eeg\Final\last15s\data/trial7/record-[2019.04.12-18.00.09]-8000.gdf';

cfg            = []; 
cfg.dataset    = gdf_1024_1808; 
cfg.continuous = 'yes'; 
cfg.channel    = 'all';
sample_data    = ft_preprocessing(cfg);

data_1024_1808= ft_read_data(gdf_1024_1808);
data_1024_1800= ft_read_data(gdf_1024_1800);
data_8000_1808= ft_read_data(gdf_8000_1808);
data_8000_1800= ft_read_data(gdf_8000_1800);

loopLength = (size(temp_1024_1808,1)+size(temp_1024_1800,1))/2;
col{1,1} = data_1024_1808(:,[temp_1024_1808(1,2):temp_1024_1808(2,2)]);
col{1,2} = data_8000_1808(:,[temp_8000_1808(1,2):temp_8000_1808(2,2)]);
col{2,1} = data_1024_1808(:,[temp_1024_1808(3,2):temp_1024_1808(4,2)]);
col{2,2} = data_8000_1808(:,[temp_8000_1808(3,2):temp_8000_1808(4,2)]);
col{3,1} = data_1024_1800(:,[temp_1024_1800(1,2):temp_1024_1800(2,2)]);
col{3,2} = data_8000_1800(:,[temp_8000_1800(1,2):temp_8000_1800(2,2)]);
col{4,1} = data_1024_1800(:,[temp_1024_1800(1,2):temp_1024_1800(2,2)]);
col{4,2} = data_8000_1800(:,[temp_8000_1800(1,2):temp_8000_1800(2,2)]);
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName)

% cooperation
addpath('D:\software\fieldtrip-20190325');
variableName = 'cooperation';
temp_1024_1739 = [32769.0,38818.0;32770.0,410744.0;32769.0,457015.0;32770.0,945445.0];
temp_8000_1739 = [32769.0,38818.0;32770.0,410744.0;32769.0,457015.0;32770.0,945445.0];
gdf_1024_1739 = 'D:\work\eeg\Final\last15s\data/trial7/record-[2019.04.12-17.39.36]-1024.gdf';
gdf_8000_1739 = 'D:\work\eeg\Final\last15s\data/trial7/record-[2019.04.12-17.39.40]-8000.gdf';
temp_1024_1747 = [32769.0,45803.0;32770.0,389556.0;32769.0,421176.0;32770.0,818584.0];
temp_8000_1747 = [32769.0,45803.0;32770.0,389556.0;32769.0,421176.0;32770.0,818584.0];
gdf_1024_1747 = 'D:\work\eeg\Final\last15s\data/trial7/record-[2019.04.12-17.47.34]-1024.gdf';
gdf_8000_1747 = 'D:\work\eeg\Final\last15s\data/trial7/record-[2019.04.12-17.47.39]-8000.gdf';

data_1024_1739= ft_read_data(gdf_1024_1739);
data_1024_1747= ft_read_data(gdf_1024_1747);
data_8000_1739= ft_read_data(gdf_8000_1739);
data_8000_1747= ft_read_data(gdf_8000_1747);
loopLength = (size(temp_1024_1747,1)+size(temp_1024_1739,1))/2;

col{1,1} = data_1024_1739(:,[temp_1024_1739(1,2):temp_1024_1739(2,2)]);
col{1,2} = data_8000_1739(:,[temp_8000_1739(1,2):temp_8000_1739(2,2)]);
col{2,1} = data_1024_1739(:,[temp_1024_1739(3,2):temp_1024_1739(4,2)]);
col{2,2} = data_8000_1739(:,[temp_8000_1739(3,2):temp_8000_1739(4,2)]);
col{3,1} = data_1024_1747(:,[temp_1024_1747(1,2):temp_1024_1747(2,2)]);
col{3,2} = data_8000_1747(:,[temp_8000_1747(1,2):temp_8000_1747(2,2)]);
col{4,1} = data_1024_1747(:,[temp_1024_1747(3,2):temp_1024_1747(4,2)]);
col{4,2} = data_8000_1747(:,[temp_8000_1747(3,2):temp_8000_1747(4,2)]);
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName)

fileNameSet = {'compet1.set','compet2.set','compet3.set','compet4.set','cooperation1.set','cooperation2.set','cooperation3.set','cooperation4.set'};
varSet = {'compet1','compet2','compet3','compet4','cooperation1','cooperation2','cooperation3','cooperation4'};
pre_process(fileNameSet,fieldTrip_save_path,varSet)
%% trial 6:
clear all;clc;close all;
addpath('D:\software\fieldtrip-20190325');
% load gdf file, export event 
% fileNameSet = {'data/trial6/record-[2019.04.10-16.30.55]-1024','data/trial6/record-[2019.04.10-16.30.59]-8000',...
%     'data/trial6/record-[2019.04.10-16.27.03]-1024','data/trial6/record-[2019.04.10-16.27.06]-8000',...
%     'data/trial6/record-[2019.04.10-16.23.09]-8000','data/trial6/record-[2019.04.10-16.23.07]-1024',...
%     'data/trial6/record-[2019.04.10-16.14.21]-8000','data/trial6/record-[2019.04.10-16.14.17]-1024',...
%     'data/trial6/record-[2019.04.10-16.06.25]-8000', 'data/trial6/record-[2019.04.10-16.06.22]-1024',...
%     'data/trial6/record-[2019.04.10-16.05.00]-8000','data/trial6/record-[2019.04.10-16.04.58]-1024',...
%     'data/trial6/record-[2019.04.10-16.01.52]-8000','data/trial6/record-[2019.04.10-16.01.49]-1024',...
%     'data/trial6/record-[2019.04.10-15.56.21]-8000','data/trial6/record-[2019.04.10-15.56.14]-1024'};
% for fileBIOSIG = 1:length(fileNameSet)
%     EEG = pop_biosig(strcat('D:\work\eeg\Final\last15s\',fileNameSet{fileBIOSIG},'.gdf'));
%     EEG = eeg_checkset( EEG );
%     pop_expevents(EEG,strcat('D:\work\eeg\Final\last15s\',fileNameSet{fileBIOSIG},'.csv') , 'samples');
% end
% run trimData.py, get event timepoints
fieldTrip_save_path = 'data/trial6/';
variableName = 'compet';
temp_1024_1630 = [32769.0,42031.0;32770.0,453134.0;32769.0,481891.0;32770.0,880010.0];
temp_8000_1630 = [32769.0,33409.0;32770.0,444527.0;32769.0,473285.0;32770.0,871391.0];
gdf_1024_1630 = 'D:\work\eeg\Final\last15s\data/trial6/record-[2019.04.10-16.30.55]-1024.gdf';
gdf_8000_1630 = 'D:\work\eeg\Final\last15s\data/trial6/record-[2019.04.10-16.30.59]-8000.gdf'; 
temp_1024_1627 = [32769.0,34079.0;32770.0,444297.0]; 
temp_8000_1627 = [32769.0,29035.0;32770.0,439253.0];
gdf_1024_1627 = 'D:\work\eeg\Final\last15s\data/trial6/record-[2019.04.10-16.27.03]-1024.gdf';
gdf_8000_1627 = 'D:\work\eeg\Final\last15s\data/trial6/record-[2019.04.10-16.27.06]-8000.gdf';
temp_1024_1623 = [32769.0,42132.0;32770.0,367112.0]; 
temp_8000_1623 = [32769.0,36968.0;32770.0,361964.0];
gdf_1024_1623 = 'D:\work\eeg\Final\last15s\data\trial6\record-[2019.04.10-16.23.07]-1024.gdf';
gdf_8000_1623 = 'D:\work\eeg\Final\last15s\data/trial6/record-[2019.04.10-16.23.09]-8000.gdf';

cfg            = [];
cfg.dataset    = gdf_1024_1623;
cfg.continuous = 'yes';
cfg.channel    = 'all';
sample_data    = ft_preprocessing(cfg);

data_1024_1630= ft_read_data(gdf_1024_1630);
data_1024_1627= ft_read_data(gdf_1024_1627);
data_1024_1623= ft_read_data(gdf_1024_1623);
data_8000_1630= ft_read_data(gdf_8000_1630);
data_8000_1627= ft_read_data(gdf_8000_1627);
data_8000_1623= ft_read_data(gdf_8000_1623);
loopLength = (size(temp_1024_1630,1)+size(temp_1024_1627,1)+size(temp_1024_1623,1))/2;

col{1,1} = data_1024_1630(:,[temp_1024_1630(1,2):temp_1024_1630(2,2)]);
col{1,2} = data_8000_1630(:,[temp_8000_1630(1,2):temp_8000_1630(2,2)]);
col{2,1} = data_1024_1630(:,[temp_1024_1630(3,2):temp_1024_1630(4,2)]);
col{2,2} = data_8000_1630(:,[temp_8000_1630(3,2):temp_8000_1630(4,2)]);
col{3,1} = data_1024_1627(:,[temp_1024_1627(1,2):temp_1024_1627(2,2)]);
col{3,2} = data_8000_1627(:,[temp_8000_1627(1,2):temp_8000_1627(2,2)]);
col{4,1} = data_1024_1623(:,[temp_1024_1623(1,2):temp_1024_1623(2,2)]);
col{4,2} = data_8000_1623(:,[temp_8000_1623(1,2):temp_8000_1623(2,2)]);
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName)

% cooperation 
variableName = 'cooperation';
addpath('D:\software\fieldtrip-20190325');
temp_1024_1614 = [32769.0,49171.0;32770.0,359390.0;32769.0,391159.0;32770.0,803680.0];
temp_8000_1614 = [32769.0,40903.0;32770.0,351111.0;32769.0,382891.0;32770.0,795424.0];
gdf_1024_1614 = 'D:\work\eeg\Final\last15s\data/trial6/record-[2019.04.10-16.14.17]-1024.gdf';
gdf_8000_1614 = 'D:\work\eeg\Final\last15s\data/trial6/record-[2019.04.10-16.14.21]-8000.gdf';
temp_1024_1606 = [32769.0,52705.0;32770.0,368227.0;32769.0,397061.0;32770.0,821593.0];
temp_8000_1606 = [32769.0,46823.0;32770.0,362358.0;32769.0,391187.0;32770.0,815723.0];
gdf_1024_1606 = 'D:\work\eeg\Final\last15s\data/trial6/record-[2019.04.10-16.06.22]-1024.gdf';
gdf_8000_1606 = 'D:\work\eeg\Final\last15s\data/trial6/record-[2019.04.10-16.06.25]-8000.gdf';
data_1024_1614= ft_read_data(gdf_1024_1614);
data_1024_1606= ft_read_data(gdf_1024_1606);
data_8000_1614= ft_read_data(gdf_8000_1614);
data_8000_1606= ft_read_data(gdf_8000_1606);
loopLength = (size(temp_1024_1606,1)+size(temp_1024_1614,1))/2;

col{1,1} = data_1024_1614(:,[temp_1024_1614(1,2):temp_1024_1614(2,2)]);
col{1,2} = data_8000_1614(:,[temp_8000_1614(1,2):temp_8000_1614(2,2)]);
col{2,1} = data_1024_1614(:,[temp_1024_1614(3,2):temp_1024_1614(4,2)]);
col{2,2} = data_8000_1614(:,[temp_8000_1614(3,2):temp_8000_1614(4,2)]);
col{3,1} = data_1024_1606(:,[temp_1024_1606(1,2):temp_1024_1606(2,2)]);
col{3,2} = data_8000_1606(:,[temp_8000_1606(1,2):temp_8000_1606(2,2)]);
col{4,1} = data_1024_1606(:,[temp_1024_1606(3,2):temp_1024_1606(4,2)]);
col{4,2} = data_8000_1606(:,[temp_8000_1606(3,2):temp_8000_1606(4,2)]);
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName);

fileNameSet = {'compet1.set','compet2.set','compet3.set','compet4.set','cooperation1.set','cooperation2.set','cooperation3.set','cooperation4.set'};
varSet = {'compet1','compet2','compet3','compet4','cooperation1','cooperation2','cooperation3','cooperation4'};
pre_process(fileNameSet,fieldTrip_save_path,varSet);

%% trial 5? no strategy, first person is missing 01,02 electrodes with hair 
clear all;clc;close all;
addpath('D:\software\fieldtrip-20190325');
fieldTrip_save_path = 'data/trial5/';
variableName = 'cooperation';
temp_1024_1657 = [32769.0,64895.0;32770.0,429889.0;32769.0,464444.0;32770.0,833558.0];
temp_8000_1657 = [32769.0,70304.0;32770.0,435312.0;32769.0,469865.0;32770.0,838997.0];
gdf_1024_1657 = 'D:\work\eeg\Final\last15s\data/trial5/record-[2019.04.09-16.57.24]-1024.gdf';
gdf_8000_1657 = 'D:\work\eeg\Final\last15s\data/trial5/record-[2019.04.09-16.57.21]-8000.gdf';
temp_1024_1704 = [32769.0,35540.0;32770.0,489607.0];
temp_8000_1704 = [32769.0,41222.0;32770.0,495294.0];
gdf_1024_1704 = 'D:\work\eeg\Final\last15s\data/trial5/record-[2019.04.09-17.04.33]-1024.gdf';
gdf_8000_1704 = 'D:\work\eeg\Final\last15s\data/trial5/record-[2019.04.09-17.04.31]-8000.gdf';
temp_1024_1711 = [32769.0,37694.0;32770.0,450989.0];
temp_8000_1711 = [32769.0,43332.0;32770.0,456640.0];
gdf_1024_1711 = 'D:\work\eeg\Final\last15s\data/trial5/record-[2019.04.09-17.11.03]-1024.gdf';
gdf_8000_1711 = 'D:\work\eeg\Final\last15s\data/trial5/record-[2019.04.09-17.11.00]-8000.gdf';

cfg            = [];
cfg.dataset    = gdf_1024_1711;
cfg.continuous = 'yes';
cfg.channel    = 'all';
sample_data           = ft_preprocessing(cfg);
data_1024_1657= ft_read_data(gdf_1024_1657);
data_1024_1704= ft_read_data(gdf_1024_1704);
data_1024_1711= ft_read_data(gdf_1024_1711);
data_8000_1657= ft_read_data(gdf_8000_1657);
data_8000_1704= ft_read_data(gdf_8000_1704);
data_8000_1711= ft_read_data(gdf_8000_1711);
loopLength = (size(temp_1024_1657,1)+size(temp_1024_1704,1)+size(temp_1024_1711,1))/2;

col{1,1} = data_1024_1657(:,[temp_1024_1657(1,2):temp_1024_1657(2,2)]);
col{1,2} = data_8000_1657(:,[temp_8000_1657(1,2):temp_8000_1657(2,2)]);
col{2,1} = data_1024_1657(:,[temp_1024_1657(3,2):temp_1024_1657(4,2)]);
col{2,2} = data_8000_1657(:,[temp_8000_1657(3,2):temp_8000_1657(4,2)]);
col{3,1} = data_1024_1704(:,[temp_1024_1704(1,2):temp_1024_1704(2,2)]);
col{3,2} = data_8000_1704(:,[temp_8000_1704(1,2):temp_8000_1704(2,2)]);
col{4,1} = data_1024_1711(:,[temp_1024_1711(1,2):temp_1024_1711(2,2)]);
col{4,2} = data_8000_1711(:,[temp_8000_1711(1,2):temp_8000_1711(2,2)]);
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName);


variableName = 'compet';
addpath('D:\software\fieldtrip-20190325');
temp_1024_1715 = [32769.0,26794.0;32770.0,275844.0;32769.0,326981.0;32770.0,725289.0];
temp_8000_1715 = [32769.0,32567.0;32770.0,281638.0;32769.0,332777.0;32770.0,731095.0];
gdf_1024_1715 = 'D:\work\eeg\Final\last15s\data/trial5/record-[2019.04.09-17.15.36]-1024.gdf';
gdf_8000_1715 = 'D:\work\eeg\Final\last15s\data/trial5/record-[2019.04.09-17.15.33]-8000.gdf';
temp_1024_1721 = [32769.0,25006.0;32770.0,543522.0;32769.0,577363.0;32770.0,885202.0];
temp_8000_1721 = [32769.0,30143.0;32770.0,548672.0;32769.0,582513.0;32770.0,890352.0];
gdf_1024_1721 = 'D:\work\eeg\Final\last15s\data/trial5/record-[2019.04.09-17.21.58]-1024.gdf';
gdf_8000_1721 = 'D:\work\eeg\Final\last15s\data/trial5/record-[2019.04.09-17.21.55]-8000.gdf';

data_1024_1715= ft_read_data(gdf_1024_1715);
data_1024_1721= ft_read_data(gdf_1024_1721);
data_8000_1715= ft_read_data(gdf_8000_1715);
data_8000_1721= ft_read_data(gdf_8000_1721);
loopLength = (size(temp_1024_1715,1)+size(temp_1024_1721,1))/2;

col{1,1} = data_1024_1715(:,[temp_1024_1715(1,2):temp_1024_1715(2,2)]);
col{1,2} = data_8000_1715(:,[temp_8000_1715(1,2):temp_8000_1715(2,2)]);
col{2,1} = data_1024_1715(:,[temp_1024_1715(3,2):temp_1024_1715(4,2)]);
col{2,2} = data_8000_1715(:,[temp_8000_1715(3,2):temp_8000_1715(4,2)]);
col{3,1} = data_1024_1721(:,[temp_1024_1721(1,2):temp_1024_1721(2,2)]);
col{3,2} = data_8000_1721(:,[temp_8000_1721(1,2):temp_8000_1721(2,2)]);
col{4,1} = data_1024_1721(:,[temp_1024_1721(3,2):temp_1024_1721(4,2)]);
col{4,2} = data_8000_1721(:,[temp_8000_1721(3,2):temp_8000_1721(4,2)]);
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName);

fileNameSet = {'cooperation2.set','cooperation3.set','cooperation4.set'};
varSet = {'cooperation2','cooperation3','cooperation4'};
pre_process(fileNameSet,fieldTrip_save_path,varSet)
%% trail 4, competition condition, read gdf into fieldtrip, X.Z with Q.C
clear all;clc;close all;
addpath('D:\software\fieldtrip-20190325');
fieldTrip_save_path = 'data/trial4/';
variableName = 'compet';
temp_1024 = [32769.0,1588811.0;32770.0,1876895.0;32769.0,1928116.0;32770.0,2302922.0;32769.0,2341961.0;32770.0,2671049.0;32769.0,2705885.0;32770.0,3033342.0];
temp_8000 = [32769.0,1490653.0;32770.0,1864915.0;32769.0,1916164.0;32770.0,2290970.0;32769.0,2330008.0;32770.0,2659097.0;32769.0,2693933.0;32770.0,3021418.0];
gdf_1024 = 'D:\work\eeg\Final\last15s\data/trial4/record-[2019.04.05-16.59.51]-1024.gdf';
gdf_8000 = 'D:\work\eeg\Final\last15s\data/trial4/record-[2019.04.05-16.59.57]-8000.gdf';
cfg            = [];
cfg.dataset    = gdf_1024;
cfg.continuous = 'yes';
cfg.channel    = 'all';
sample_data    = ft_preprocessing(cfg);
data_1024= ft_read_data(gdf_1024);
data_8000 = ft_read_data(gdf_8000);
loopLength = size(temp_1024,1)/2;
for  i =1:loopLength
    col{i,1} = data_1024(:,[temp_1024(i,2):temp_1024(2*i,2)]);
    col{i,2} = data_8000(:,[temp_8000(i,2):temp_8000(2*i,2)]);
end
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName);

variableName = 'cooperation';
addpath('D:\software\fieldtrip-20190325');
temp_8000 = [32769.0,166367.0;32770.0,405406.0;32769.0,479089.0;32770.0,773960.0;32769.0,811843.0;32770.0,1101875.0;32769.0,1121740.0;32770.0,1472327.0];
temp_1024 = [32769.0,166367.0;32770.0,405406.0;32769.0,479089.0;32770.0,773960.0;32769.0,811843.0;32770.0,1101875.0;32769.0,1121740.0;32770.0,1472327.0];
loopLength = size(temp_1024,1)/2;
for  i =1:loopLength
    col{i,1} = data_1024(:,[temp_1024(i,2):temp_1024(2*i,2)]);
    col{i,2} = data_8000(:,[temp_8000(i,2):temp_8000(2*i,2)]);
end
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName);

fileNameSet = {'compet1.set','compet2.set','compet3.set','compet4.set','cooperation1.set','cooperation2.set','cooperation3.set','cooperation4.set'};
varSet = {'compet1','compet2','compet3','compet4','cooperation1','cooperation2','cooperation3','cooperation4'};
pre_process(fileNameSet,fieldTrip_save_path,varSet)
%% trial 3: Laura with Q.C
% extract the middle 30seconds in each session, finished in EEGLab manually
% fileNameSet = {'compet1_1.set','compet1_2.set','compet2_1.set','compet2_2.set',...
%     'compet3_1.set','compet3_2.set','compet4_1.set','compet4_2.set'...
%     'cooperation1_1.set','cooperation1_2.set','cooperation2_1.set','cooperation2_2.set',...
%     'cooperation3_1.set','cooperation3_2.set','cooperation4_1.set','cooperation4_2.set'};
% varSet = {'compet1_1','compet1_2','compet2_1','compet2_2','compet3_1','compet3_2',...
%     'compet4_1','compet4_2','cooperation1_1','cooperation1_2', ...
%     'cooperation2_1','cooperation2_2','cooperation3_1','cooperation3_2','cooperation4_1','cooperation4_2'};
% 
% for fileI = 1:length(fileNameSet)
%     EEG = pop_loadset('filename',fileNameSet{fileI},'filepath','data/trial3/');
%     EEG=pop_chanedit(EEG, 'lookup','D:\\software\\eeglab14_1_2b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp','load',{'loc.ced' 'filetype' 'autodetect'});
%     EEG = pop_resample( EEG, 128);
%     EEG = pop_eegfiltnew(EEG, 1,45,424,0,[],1); % filter 1-45Hz
% %     EEG_selected = pop_select( EEG,'time',[5 EEG.xmax-5]); % remove the first and last 5 seconds 
%     EEG_selected = pop_select( EEG,'channel',find(~all(EEG.data(:,:,1)==0,2))); % remove channels with all zeros 
% %     EEG_selected = eeg_regepochs(EEG_selected,'recurrence',0.5,'limits',[0 1],'rmbase', NaN);
%     [~,EEG_selected,~] = processMARA([],EEG_selected,[],[0,1,0,0,1]); %Run MARA ,automatically components remove 
%     pop_saveset(EEG_selected, 'filename',strcat(varSet{fileI},'.set'),'filepath','data/trial3/');
% end

%% trial2 C.G with 
clear all;clc;close all;
addpath('D:\software\fieldtrip-20190325');
fieldTrip_save_path = 'data/trial2/';
variableName = 'compet';
temp_1024 = [32769.0,406397.0;32770.0,692703.0;32769.0,761504.0;32770.0,1111901.0;32769.0,1170481.0;32770.0,1563601.0;32769.0,1607109.0;32770.0,1867923.0];
temp_8000 = [32769.0,410849.0;32770.0,697128.0;32769.0,765929.0;32770.0,1111901.0;32769.0,1170481.0;32770.0,1563601.0;32769.0,1607109.0;32770.0,1867923.0];
gdf_1024 = 'D:\work\eeg\Final\last15s/data/trial2/record-[2019.03.29-18.45.42]-1024.gdf';
gdf_8000 = 'D:\work\eeg\Final\last15s/data/trial2/record-[2019.03.29-18.45.40]-8000.gdf';
cfg            = [];
cfg.dataset    = gdf_1024;
cfg.continuous = 'yes';
cfg.channel    = 'all';
sample_data    = ft_preprocessing(cfg);
data_1024= ft_read_data(gdf_1024);
data_8000 = ft_read_data(gdf_8000);
loopLength = size(temp_1024,1)/2;
for  i =1:loopLength
    col{i,1} = data_1024(:,[temp_1024(i,2):temp_1024(2*i,2)]);
    col{i,2} = data_8000(:,[temp_8000(i,2):temp_8000(2*i,2)]);
end
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName);


% read cooperation and save into D:\work\eeg\Final\last15s\data/trial4/ directory  
temp_8000 = [32769.0,1984817.0;32770.0,2180751.0;32769.0,2225747.0;32770.0,2409224.0;32769.0,2451972.0;32770.0,2644423.0;32769.0,2678438.0;32770.0,2900347.0];
temp_1024 = [32769.0,1984817.0;32770.0,2180751.0;32769.0,2225747.0;32770.0,2409224.0;32769.0,2451972.0;32770.0,2644423.0;32769.0,2678438.0;32770.0,2900347.0];
variableName = 'cooperation';
addpath('D:\software\fieldtrip-20190325');
loopLength = size(temp_1024,1)/2;
for  i =1:loopLength
    col{i,1} = data_1024(:,[temp_1024(i,2):temp_1024(2*i,2)]);
    col{i,2} = data_8000(:,[temp_8000(i,2):temp_8000(2*i,2)]);
end
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName);

clear all;close all;clc;
fieldTrip_save_path = 'data/trial2/';
fileNameSet = {'compet4.set','cooperation1.set','cooperation2.set','cooperation3.set','cooperation4.set'};
varSet = {'compet4','cooperation1','cooperation2','cooperation3','cooperation4'};
pre_process(fileNameSet,fieldTrip_save_path,varSet)
%% trial1 N.H with Q.C
clear all; clc; close all;
addpath('D:\software\fieldtrip-20190325');
fieldTrip_save_path = 'data/trial1/';
variableName = 'compet';
temp_1024 = [32769.0,514011.0;32770.0,830056.0;32769.0,854430.0;32770.0,1210591.0;32769.0,1226711.0;32770.0,1607692.0;32769.0,1611805.0;32770.0,1987892.0];
temp_8000 = [32769.0,511145.0;32770.0,827166.0;32769.0,851549.0;32770.0,1207698.0;32769.0,1223816.0;32770.0,1604798.0;32769.0,1608911.0;32770.0,1984971.0];
gdf_1024 = 'D:\work\eeg\Final\last15s\data/trial1/record-[2019.03.25-19.15.33].gdf';
gdf_8000 = 'D:\work\eeg\Final\last15s\data/trial1/record-[2019.03.25-19.15.34]-2.gdf';
cfg            = [];
cfg.dataset    = gdf_1024;
cfg.continuous = 'yes';
cfg.channel    = 'all';
sample_data    = ft_preprocessing(cfg);


data_1024= ft_read_data(gdf_1024);
data_8000 = ft_read_data(gdf_8000);
loopLength = size(temp_1024,1)/2;
for  i =1:loopLength
    col{i,1} = data_1024(:,[temp_1024(i,2):temp_1024(2*i,2)]);
    col{i,2} = data_8000(:,[temp_8000(i,2):temp_8000(2*i,2)]);
end
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName);

variableName = 'cooperation';
addpath('D:\software\fieldtrip-20190325');
temp_8000 = [32769.0,2055478.0;32770.0,2284732.0;32769.0,2479492.0;32770.0,2691882.0;32769.0,2696502.0;32770.0,2869063.0;32769.0,2874414.0;32770.0,3044441.0];
temp_1024 = [32769.0,2052545.0;32770.0,2281850.0;32769.0,2476612.0;32770.0,2688987.0;32769.0,2693579.0;32770.0,2866150.0;32769.0,2871518.0;32770.0,3041531.0];
loopLength = size(temp_1024,1)/2;
for  i =1:loopLength
    col{i,1} = data_1024(:,[temp_1024(i,2):temp_1024(2*i,2)]);
    col{i,2} = data_8000(:,[temp_8000(i,2):temp_8000(2*i,2)]);
end
pre_save_file(loopLength,col,sample_data,fieldTrip_save_path,variableName);
fileNameSet = {'compet1.set','compet2.set','compet3.set','compet4.set','cooperation1.set','cooperation2.set','cooperation3.set','cooperation4.set'};
varSet = {'compet1','compet2','compet3','compet4','cooperation1','cooperation2','cooperation3','cooperation4'};
pre_process(fileNameSet,fieldTrip_save_path,varSet)