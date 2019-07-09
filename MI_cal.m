function mu_mat = MI_cal(fileName1,fileName2,dicPath,fileNo1,binNum)
    % mutual information based connectivity 
    % trail_all: channll x timepoints x trial
    % binNum: how many bins used to historgam data
    % normalized mutual information is returned.
    if ~exist('binNum','var')
        binNum = 1000;
    end
    chanNum1 =23; % channel amount 
    chanNum2 =23; % channel amount of the second signal
    mu_mat = cell(chanNum1+chanNum1,chanNum2+chanNum2);
    for channI = 1:chanNum1
       for channII = 1:chanNum1 
        % loop for 1-45 frequecies 
        temp = zeros(89,1);
        for freqI = 1:.5:45 % correspond to power and phase 
            [averagedEEG,~] =  filterEEG(fileName1,fileName2,freqI,dicPath,fileNo1);
            temp(2*freqI -1) = mi(averagedEEG(channI,:),averagedEEG(channII,:),binNum);
        end
        mu_mat{channI,channII} = temp;
       end 
    end
    
     for channI = 1:chanNum2
       for channII = 1:chanNum2 
            temp = zeros(89,1);
            for freqI = 1:.5:45 % correspond to power and phase 
                [~,averagedEEG2] =  filterEEG(fileName1,fileName2,freqI,dicPath,fileNo1);
                temp(2*freqI -1) = mi(averagedEEG2(channI,:),averagedEEG2(channII,:),binNum);
            end
            mu_mat{channI+chanNum1,channII+chanNum1} = temp;
       end 
     end
    
    for channI = 1:chanNum1
       for channII = 1:chanNum2 
            temp = zeros(89,1);
            for freqI = 1:.5:45 % correspond to power and phase 
                [averagedEEG,averagedEEG2] = filterEEG(fileName1,fileName2,freqI,dicPath,fileNo1);
                temp(2*freqI -1) = mi(averagedEEG(channI,:),averagedEEG2(channII,:),binNum);
            end
            mu_mat{channI,channII+chanNum1} = temp;
            mu_mat{channII+chanNum1,channI} = temp;
       end 
    end
end

function [averagedEEG,averagedEEG2] = filterEEG(fileName1,fileName2,freqNum,dicPath,fileNo1)    
    EEG1 = pop_loadset('filename',strcat(fileName1,'.set'),'filepath',dicPath);
    EEG2 = pop_loadset('filename',strcat(fileName2,'.set'),'filepath',dicPath);
    % apply beta frequency only, from 13 to 30 Hz
    % for frequency band from 1 to 45
    EEG1 = pop_eegfiltnew(EEG1,freqNum,freqNum,500,0,[],1);
    EEG2 = pop_eegfiltnew(EEG2,freqNum,freqNum,500,0,[],1);
    
    averagedEEG = mean(EEG1.data,3); % average over frequency 
    averagedEEG2 = mean(EEG2.data,3);
    [~,timePoints] = size(averagedEEG);
    [~,timePoints2] = size(averagedEEG2);
    if (fileNo1 == 1|| fileNo1 == 3 || fileNo1 == 47 || fileNo1 == 51) % missing 18
        averagedEEG = vertcat(averagedEEG(1:17,:),zeros(1,timePoints),averagedEEG(18:end,:));
    elseif (fileNo1 == 19 || fileNo1 == 21 || fileNo1 == 23 || fileNo1 == 25 || fileNo1 == 71 || ...
         fileNo1 == 69 ||  fileNo1 == 67 ||  fileNo1 == 65 ) % missing 21,22
        averagedEEG = vertcat(averagedEEG(1:20,:),zeros(2,timePoints),averagedEEG(21:end,:));
    elseif ( fileNo1 == 33 || fileNo1 == 31 ||  fileNo1 == 83 ||  fileNo1 == 81) % missing 9, 23
        averagedEEG = vertcat(averagedEEG(1:8,:),zeros(1,timePoints),averagedEEG(9:end,:),zeros(1,timePoints));
    end
    
    fileNo2 = fileNo1 + 1;
    if (fileNo2 == 2 || fileNo2 == 4 ||fileNo2 == 6 || fileNo2 == 8 ||  fileNo2 == 46 ||  fileNo2 == 48 ||...
         fileNo2 == 50 ||  fileNo2 == 52) % missing 21
        averagedEEG2 = vertcat(averagedEEG2(1:20,:),zeros(1,timePoints2),averagedEEG2(21:end,:));
    elseif  (fileNo2 == 10 || fileNo2 == 12 || fileNo2 == 14 || fileNo2 == 16|| fileNo2 == 60 || ...
         fileNo2 == 58 ||  fileNo2 == 56 ||  fileNo2 == 54)
        averagedEEG2 = vertcat(zeros(1,timePoints2),averagedEEG2(1:end,:));
    end
end 