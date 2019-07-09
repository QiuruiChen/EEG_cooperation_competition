## Team neural dynamic analysis during cooperation and comeptition with EEG

## Steps
1. Run pre_proc.m
- Genertae dataset in the eeglab and filedtrip format 
- Resample 128Hz
- Filter 1-45Hz
- Remove first and last 5s
- Obtain the last 15s as intereated data
- Remove DC channels (signals with zero value)
- MARA: remove noise components,  and drop the data if its artificat components is > 60% of all ica components
- Save remains into data/useful directory

- Finally we have:
    - 22 trials for competition
    - 25 trials for cooperation
    - check data/info.txt file

2. Run timeFrequency.m
- Calculate the spectral estimation and normalzied power for each trial
- Use pop_newtimef funnction (eeglabe function)
    - ERSP = averaged power (averaged over epoches amount):  save with "trial_name_allersp.mat" 
    - ITPC = normalzied time-frequency:  save with "trial_name_allitc.mat" format

- Notably, the frequency and time, which are returned by pop_newtimef function for each time-frequency analysis is different.
Here, 1409 frequwncy (ranging from 0 to 45Hz) and  60 timepoints (ranging from 0 to 15 seonds) are applied 


3. Run conn_cal.m to calculate inter-brain synchcrony over frequency and/or time
- Over frequency and time: 
    - ispc, spectral-coherence,pli,power-correlation: beta band (13-30)
    - MI: gamma band (31-45), 1000 bins 

- Calcculate functional connectiveity over frequency and over time: power-correlation and ISPC(phase-based)

4. Run conn_combined.m
- Combine each trials into one mat

5. Run conn_sig.m /conn_sig_permutation.m
- Conn_sig.m: 
    1. Do non-parametric test, get the real p value, 
    2. Do permutation test get 1000 p-value
    3. Test the real-p value weather is significant in all p-values 
- Conn_sig_permutation.m:
    - Permutation test with 500 shuffles ( threshold: 1%)
    - Mannes recommended: the results paper applied

- False discrovery rate: 5%

6. Run plot_network_group.m;

- Plot_network_group.m;
    - Plot strong NS: addjacency matrix and brain maps
    - Threshold: one std + median of intra- and inter-brain NS
    - Outliers(a value that is more than three scaled median absolute deviations) were removed 
    
    - Commented code: plot granger causality in the end of this file

- plot_network_group2.m:
    - Plot strong NS in brain maps
    - Threshold:
        - for intra-brain NS, the threshold is visually detected by the distribution of intra-brain NS
        - for INS, the top 10 highest INSs were chosen 

- Plot_NS_over_time_freq:
    - Plot all intra- and inter-brain NS over time and frequency, 
    - Time-consusing since there 441 plot for frequency and time and each trial 

- Plot_net_prop_over_freq.m
    - Plot the boxplot of gloabl efficiency and small-world-ness over frequncy/time 
    - Plot the lineplot of GE/SWN of the median of team-brain network over frequency/tiime 



7. Run network_properties.m

- Calcualate unthresholded weighted network properties and save into data/conn
- Brain Connectivity Toolbox(BCT) should be added into path

8. Run cal_smallworldness.m 

- Method: Based on ER random network and transitivity clustering coefficient 
- Add path the library smallworldness-matser 
- Calculate SWN of intra- and team-brain network 

9. GE_cal: calculate global efficiency 

- Calculate GE of intra- and team-brain netwroks
- Add path Brain Connectivity Toolbox 


9. Run behavorial_glm.m

    1. Fit linear polynomial curves between game duration and INS/GE 
    Game duration is listed in the data/info.txt 
    2. Plot the betweeness centrality in brain maps
    
