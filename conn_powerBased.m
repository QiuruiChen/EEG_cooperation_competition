 function [corr_power_over_freq] = conn_powerBased(fileName1,fileName2,saveName,fileNo1,TimeOrFreq)
% calcaulte power-correlation connectivity
% TimeOrFreq == 0: average frequency and time
% TimeOrFreq == 1: calcultae ispc over time (last 15s)
% TimeOrFreq == 2: calculate ispc over frequency (1-45Hz)
% fileName1, fileName1: two rsp mat files from two target signals
% fileNo1: file number, which is used for name saving 

% output: save corr_power_over_freq,corr_power_over_time and corr_power
% mat files 

    allersp1 = load(fileName1, 'allersp'); % load power data
    allersp1 = allersp1.allersp;

    allersp2 = load(fileName2, 'allersp'); % Load in ONLY the myVar variable.
    allersp2 = allersp2.allersp;
    [freq1,timePoint1,~] = size(allersp1);
    [freq2,timePoint2,~] = size(allersp2);
    fprintf('calculating inter-subject power-based connectivity between %s and %s.\n',fileName1,fileName2);

    if (fileNo1 == 1|| fileNo1 == 3 || fileNo1 == 47 || fileNo1 == 51) % missing 18
        allersp1 = cat(3,allersp1(:,:,1:17),zeros(freq1,timePoint1,1),allersp1(:,:,18:end));
    elseif (fileNo1 == 19 || fileNo1 == 21 || fileNo1 == 23 || fileNo1 == 25 || fileNo1 == 71 || ...
             fileNo1 == 69 ||  fileNo1 == 67 ||  fileNo1 == 65 ) % missing 21,22
        allersp1 = cat(3,allersp1(:,:,1:20),zeros(freq1,timePoint1,2),allersp1(:,:,21:end));
    elseif ( fileNo1 == 33 || fileNo1 == 31 ||  fileNo1 == 83 ||  fileNo1 == 81) % missing 9, 23
        allersp1 = cat(3,allersp1(:,:,1:8),zeros(freq1,timePoint1,1),allersp1(:,:,9:end),zeros(freq1,timePoint1,1));
    end

    fileNo2 = fileNo1 + 1;
    if (fileNo2 == 2 || fileNo2 == 4 ||fileNo2 == 6 || fileNo2 == 8 ||  fileNo2 == 46 ||  fileNo2 == 48 ||...
             fileNo2 == 50 ||  fileNo2 == 52) % missing 21
        allersp2 = cat(3,allersp2(:,:,1:20),zeros(freq2,timePoint2,1),allersp2(:,:,21:end));
    elseif (fileNo2 == 10 || fileNo2 == 12 || fileNo2 == 14 || fileNo2 == 16|| fileNo2 == 60 || ...
             fileNo2 == 58 ||  fileNo2 == 56 ||  fileNo2 == 54)
        allersp2 = cat(3,zeros(freq2,timePoint2,1),allersp2(:,:,1:end));
    end
    channNum = 23;
    channNum2 = 23;
    if TimeOrFreq == 0
        corr_power.corr_alpha = zeros(channNum+channNum2,channNum2+channNum);
        [corr_power] = cal_conn(allersp1,allersp2,channNum,channNum2,TimeOrFreq,corr_power);
        corr_power.corr_alpha = triu(corr_power.corr_alpha)+triu(corr_power.corr_alpha,1)';
        save(saveName,'corr_power');
    else 
        corr_power_over_freq.corr_alpha = cell(channNum+channNum2,channNum2+channNum);
        [corr_power_over_freq] = cal_conn(allersp1,allersp2,channNum,channNum2,TimeOrFreq,corr_power_over_freq);
        save(saveName,'corr_power_over_freq');

    end
 end

function [corr_power] = cal_conn(allersp1,allersp2,channNum,channNum2,TimeOrFreq,corr_power)
     for chanI = 1:channNum
        for chanII = chanI:channNum
            analyticsignal1        = allersp1(:,:,chanI);
            analyticsignal2        = allersp1(:,:,chanII);
             [expl_corrs] = cal_power(analyticsignal1,analyticsignal2,TimeOrFreq);
             if TimeOrFreq == 0
                corr_power.corr_alpha(chanI,chanII)  = mean(expl_corrs(8*2-1:12*2-1,:));
             else
                corr_power.corr_alpha{chanI,chanII}  = expl_corrs;
                corr_power.corr_alpha{chanII,chanI}  = expl_corrs;
             end
        end
    end

    for chanI = 1:channNum2
        for chanII = chanI:channNum2
            analyticsignal1        = allersp2(:,:,chanI);
            analyticsignal2        = allersp2(:,:,chanII);
             [expl_corrs] = cal_power(analyticsignal1,analyticsignal2,TimeOrFreq);
            if  TimeOrFreq == 0 %average over frequency and time
                corr_power.corr_alpha(channNum+chanI,channNum+chanII)  = mean(expl_corrs(8*2-1:12*2-1,:));
            else
                corr_power.corr_alpha{channNum+chanI,channNum+chanII}  =expl_corrs;
                corr_power.corr_alpha{channNum+chanII,channNum+chanI}  =expl_corrs;
            end
        end
    end

    for chanI = 1:channNum
        for chanII = 1:channNum2
            analyticsignal1        = allersp1(:,:,chanI);
            analyticsignal2        = allersp2(:,:,chanII);
            [expl_corrs] = cal_power(analyticsignal1,analyticsignal2,TimeOrFreq);
            if TimeOrFreq == 0
                temp = mean(expl_corrs(8*2-1:12*2-1,:));
                corr_power.corr_alpha(chanI,channNum+chanII)  = temp;
                corr_power.corr_alpha(channNum+chanII,chanI)  = temp;
            else 
                temp = expl_corrs;
                corr_power.corr_alpha{chanI,channNum+chanII} = temp;
                corr_power.corr_alpha{channNum+chanII,chanI}  = temp;   
            end
        end
    end
end
 

function final_matrix = add_triu(temp_matrix)
temp_matrix = temp_matrix + triu(temp_matrix)';
final_matrix = temp_matrix - diag(diag(temp_matrix))/2;
end

function [expl_corrs] = cal_power(analyticsignal1,analyticsignal2,TimeOrFreq) 
[freqs,times] = size(analyticsignal1);
        if TimeOrFreq == 1  % cal con over time
            expl_corrs = zeros(times,1);
            analyticsignal1 = analyticsignal1(25:59,:);
            analyticsignal2 = analyticsignal2(25:59,:);
            for ti=1:times  
                expl_corrs(ti) = corr(tiedrank(analyticsignal1(:,ti)),tiedrank(analyticsignal2(:,ti)),'type','s');
            end
        elseif (TimeOrFreq ==2 ||  TimeOrFreq ==0)% cal con over frequenceies
            expl_corrs = zeros(freqs,1);
            for fi=1:freqs  
                expl_corrs(fi) = corr(tiedrank(analyticsignal1(fi,:)'),tiedrank(analyticsignal2(fi,:)'),'type','s');
            end
        else 
            error('TimeOrFreq can only be 0 or 1 or 2');
        end
end