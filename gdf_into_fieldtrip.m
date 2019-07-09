function gdf_into_fieldtrip(temp_1024,temp_8000,gdf_1024,gdf_8000,fieldTrip_save_path,variableName)
%%  define trials
cfg            = [];
cfg.dataset    = gdf_1024;
cfg.continuous = 'yes';
cfg.channel    = 'all';
sample_data           = ft_preprocessing(cfg);
%% 
data_1024= ft_read_data(gdf_1024);
data_8000 = ft_read_data(gdf_8000);
%% 32769 is start, 32770 is end 
loopLength = size(temp_1024,1)/2;
for  i =1:loopLength
    col{i,1} = data_1024(:,[temp_1024(i,2):temp_1024(2*i,2)]);
    col{i,2} = data_8000(:,[temp_8000(i,2):temp_8000(2*i,2)]);
end
%%
for i=1:loopLength
    col1 = col{i,1}; col2 = col{i,2};
    col_temp{i,1} = col1(:,[1: min(size(col1,2),size(col2,2))]);
    col_temp{i,2} = col2(:,[1: min(size(col1,2),size(col2,2))]);
end
%%
for i=1:loopLength
    cfg = []; data= [];
    data.trial{1,1} = col_temp{i,1} ;
    data.trial{1,2} = col_temp{i,2} ;
    interval = 1/sample_data.fsample;
    data.time{1,1} = 0:interval:interval * (size(col_temp{i,1},2)-1);
    data.time{2,1} = 0:interval:interval * (size(col_temp{i,1},2)-1);
    data.label = sample_data.label;
    data.fsample = sample_data.fsample;

    [compet] = ft_preprocessing (cfg, data);
    save_compet{i} = compet;
end

for i = 1:loopLength
    compet = save_compet{i};
    save(strcat(fieldTrip_save_path,variableName,num2str(i)),'compet');
end
for i = 1:loopLength
    compet = save_compet{i};
    fieldtrip2eeglab_min(compet,strcat(variableName,num2str(i)),fieldTrip_save_path);
end
end