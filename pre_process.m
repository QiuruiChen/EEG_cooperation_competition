function pre_process(fileNameSet,fileDirec,varSet)
    for fileI = 1:length(fileNameSet)
        EEG = pop_loadset('filename',fileNameSet{fileI},'filepath',fileDirec);
        EEG=pop_chanedit(EEG, 'lookup','D:\\software\\eeglab14_1_2b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp','load',{'loc.ced' 'filetype' 'autodetect'});
        EEG = pop_resample( EEG, 256);
        EEG = pop_eegfiltnew(EEG, 1,45,424,0,[],1); % filter 1-45Hz
        for i =1:2
%             EEG_selected = pop_select( EEG,'time',[5 EEG.xmax-5] ,'trial',i); % remove the first and last 5 seconds
            EEG_selected = pop_select( EEG,'time',[EEG.xmax-21 EEG.xmax-5] ,'trial',i); % remove the first and last 5 seconds 
            EEG_selected = pop_select( EEG_selected,'channel',find(~all(EEG_selected.data(:,:,1)==0,2))); % remove channels with all zeros 
%             EEG_selected = eeg_regepochs(EEG_selected,'recurrence',0.5,'limits',[0 1],'rmbase', NaN); % extract 1 seconds epoch,overlapping 0.5s
            [~,EEG_selected,~] = processMARA([],EEG_selected,[],[0,1,0,0,1]); %Run MARA ,automatically components remove 
            pop_saveset(EEG_selected, 'filename',strcat(varSet{fileI},'_',num2str(i),'.set'),'filepath',fileDirec);
        end
    end
end