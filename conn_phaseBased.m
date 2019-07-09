function conn_phaseBased(fileName1, fileName2, saveName,fileNo1,TimeOrFreq)
% calcaulte phase-based connectivity 
% TimeOrFreq == 0: average frequency and time, calculate ispc, pli and
% spectral coherence 
% TimeOrFreq == 1: calcultae ispc over time (last 15s)
% TimeOrFreq == 2: calculate ispc over frequency (1-45Hz)
% fileName1, fileName1: two itc mat files from two target signals
% fileNo1: file number, which is used for name saving 

% output: save corr_phase_over_freq,corr_phase_over_time and corr_phase
% mat files 

sig1 = load(fileName1,'allitc');
sig1 = sig1.allitc;
sig2 = load(fileName2,'allitc');
sig2 = sig2.allitc;

[freq1,timePoint1,~] = size(sig1);
[freq2,timePoint2,~] = size(sig2);
fprintf('calculating inter-subject phase-based connectivity between %s and %s.\n',fileName1,fileName2);

if (fileNo1 == 1|| fileNo1 == 3 || fileNo1 == 47 || fileNo1 == 51) % missing 18
    sig1 = cat(3,sig1(:,:,1:17),zeros(freq1,timePoint1,1),sig1(:,:,18:end));
elseif (fileNo1 == 19 || fileNo1 == 21 || fileNo1 == 23 || fileNo1 == 25 || fileNo1 == 71 || ...
         fileNo1 == 69 ||  fileNo1 == 67 ||  fileNo1 == 65 ) % missing 21,22
    sig1 = cat(3,sig1(:,:,1:20),zeros(freq1,timePoint1,2),sig1(:,:,21:end));
elseif ( fileNo1 == 33 || fileNo1 == 31 ||  fileNo1 == 83 ||  fileNo1 == 81) % missing 9, 23
    sig1 = cat(3,sig1(:,:,1:8),zeros(freq1,timePoint1,1),sig1(:,:,9:end),zeros(freq1,timePoint1,1));
end

fileNo2 = fileNo1 + 1;
if (fileNo2 == 2 || fileNo2 == 4 ||fileNo2 == 6 || fileNo2 == 8 ||  fileNo2 == 46 ||  fileNo2 == 48 ||...
         fileNo2 == 50 ||  fileNo2 == 52) % missing 21
    sig2 = cat(3,sig2(:,:,1:20),zeros(freq2,timePoint2,1),sig2(:,:,21:end));
elseif (fileNo2 == 10 || fileNo2 == 12 || fileNo2 == 14 || fileNo2 == 16|| fileNo2 == 60 || ...
         fileNo2 == 58 ||  fileNo2 == 56 ||  fileNo2 == 54)
    sig2 = cat(3,zeros(freq2,timePoint2,1),sig2(:,:,1:end));
end

chanNum = 23;
chanNum2 =23;
if TimeOrFreq == 0
    corr_phase = {};
    [corr_phase] = cal_conn(chanNum,chanNum2,sig1,sig2,TimeOrFreq,corr_phase);
    save(saveName,'corr_phase');
elseif TimeOrFreq == 2
    corr_phase_over_freq = {};
    [corr_phase_over_freq] = cal_conn(chanNum,chanNum2,sig1,sig2,TimeOrFreq,corr_phase_over_freq);
    save(saveName,'corr_phase_over_freq');
elseif TimeOrFreq == 1
    corr_phase_over_time = {};
    [corr_phase_over_time] = cal_conn(chanNum,chanNum2,sig1,sig2,TimeOrFreq,corr_phase_over_time);
    save(saveName,'corr_phase_over_time');
else
    error("TimeOrFreq can only be 0,1 or 2");
end
end 


function [corr_phase]=cal_conn(chanNum,chanNum2,sig1,sig2,TimeOrFreq,corr_phase)
for chanI = 1:chanNum
    for chanII = 1:chanNum
        % ISPC
        % cross-spectral density
        sig_temp1 = sig1(:,:,chanI);
        sig_temp2 = sig1(:,:,chanII);
        cdd = sig_temp1 .* conj(sig_temp2);
        if TimeOrFreq == 0
            ispc = abs(mean(exp(1i*angle(cdd)),2));
            % note: equivalent to ispc(fi,:) = abs(mean(exp(1i*(angle(sig1)-angle(sig2))),2));
            cdi = imag(cdd); % take imaginary part of signal only
            pli  = abs(mean(sign(imag(cdd)),2)); % phase-lag index
            % weighted phase-lag index (eq. 8 in Vink et al. NeuroImage 2011)
            % wpli= abs( mean( abs(cdi).*sign(cdi) ,2) )./mean(abs(cdi),2);

            spec1 = mean(sig_temp1.*conj(sig_temp1),2);
            spec2 = mean(sig_temp2.*conj(sig_temp2),2);
            specX = abs(mean(cdd,2)).^2;
            % compute spectral coherence, using only requested time points
            spectcoher= specX./(spec1.*spec2);
            corr_phase.ispc(chanI,chanII)  = mean(ispc(1*2-1:45*2-1,:));
            corr_phase.pli(chanI,chanII)  = mean(pli(1*2-1:45*2-1,:));
            corr_phase.spectcoher(chanI,chanII)  = mean(spectcoher(1*2-1:45*2-1,:));s
        elseif TimeOrFreq == 1 % caal conn over time
            temp = exp(1i*angle(cdd));
            ispc = abs(mean(temp((2*13-1):(2*30-1),:),1));  % average over frequencies 
            corr_phase.ispc{chanI,chanII}  = ispc;
        elseif TimeOrFreq ==2 % cal conn over frequencies
            ispc = abs(mean(exp(1i*angle(cdd)),2));  %  average over time
            corr_phase.ispc{chanI,chanII}  = ispc;
        else
            error('TimeOrFreq can only be 0, 1 or 2');
        end
    end 
end 

for chanI = 1:chanNum2
    for chanII = 1:chanNum2
        sig_temp1 = sig2(:,:,chanI);
        sig_temp2 = sig2(:,:,chanII);
        cdd = sig_temp1 .* conj(sig_temp2);
        if  TimeOrFreq == 0
            ispc = abs(mean(exp(1i*angle(cdd)),2));
            pli  = abs(mean(sign(imag(cdd)),2)); % phase-lag index
            spec1 = mean(sig_temp1.*conj(sig_temp1),2);
            spec2 = mean(sig_temp2.*conj(sig_temp2),2);
            specX = abs(mean(cdd,2)).^2;
            spectcoher= specX./(spec1.*spec2);

            corr_phase.ispc(chanI+chanNum,chanII+chanNum)  = mean(ispc(1*2-1:45*2-1,:));
            corr_phase.pli(chanI+chanNum,chanII+chanNum)  = mean(pli(1*2-1:45*2-1,:));
            corr_phase.spectcoher(chanI+chanNum,chanII+chanNum)  = mean(spectcoher(1*2-1:45*2-1,:));
        elseif TimeOrFreq == 1 % caal conn over time
            temp = exp(1i*angle(cdd));
            ispc = abs(mean(temp((2*13-1):(2*30-1),:),1));  % average over frequencies 
            corr_phase.ispc{chanI+chanNum,chanII+chanNum}  = ispc;
        elseif TimeOrFreq ==2 % cal conn over frequencies
            ispc = abs(mean(exp(1i*angle(cdd)),2));  %  average over time
            corr_phase.ispc{chanI+chanNum,chanII+chanNum}  = ispc;
        else
            error('TimeOrFreq can only be 1 or 2');
        end
    end 
end 

for chanI = 1:chanNum
    for chanII = 1:chanNum2
        sig_temp1 = sig1(:,:,chanI);
        sig_temp2 = sig2(:,:,chanII);
        cdd = sig_temp1 .* conj(sig_temp2);
        if TimeOrFreq == 0
            pli  = abs(mean(sign(imag(cdd)),2));     % phase-lag index 
            spec1 = mean(sig_temp1.*conj(sig_temp1),2);
            spec2 = mean(sig_temp2.*conj(sig_temp2),2);
            specX = abs(mean(cdd,2)).^2;
            spectcoher= specX./(spec1.*spec2);
            corr_phase.ispc(chanI,chanII+chanNum)  = mean(ispc(1*2-1:45*2-1,:));
            corr_phase.pli(chanI,chanII+chanNum)  = mean(pli(1*2-1:45*2-1,:));
            corr_phase.spectcoher(chanI,chanII+chanNum)  = mean(spectcoher(1*2-1:45*2-1,:));
            corr_phase.ispc(chanII+chanNum,chanI)  = mean(ispc(1*2-1:45*2-1,:));
            corr_phase.pli(chanII+chanNum,chanI)  = mean(pli(1*2-1:45*2-1,:));
            corr_phase.spectcoher(chanII+chanNum,chanI)  = mean(spectcoher(1*2-1:45*2-1,:));
        elseif TimeOrFreq == 1 % caal conn over time
           temp = exp(1i*angle(cdd));
           ispc = abs(mean(temp((2*13-1):(2*30-1),:),1));  % average over frequencies 
           corr_phase.ispc{chanI,chanII+chanNum}  = ispc;
           corr_phase.ispc{chanII+chanNum,chanI}  = ispc;
        elseif TimeOrFreq ==2 % cal conn over frequencies
            ispc = abs(mean(exp(1i*angle(cdd)),2));  %  average over time
            corr_phase.ispc{chanI,chanII+chanNum}  = ispc;
           corr_phase.ispc{chanII+chanNum,chanI}  = ispc;
        else
            error('TimeOrFreq can only be 1 or 2');
        end
    end 
end 
end