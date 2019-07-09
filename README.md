## Team neural dynamic analysis during cooperation and comeptition with EEG

## Summary 

The ’social brain’ has become a central focus of interest in neuroscience research in order to define the neurophysiological basis of social behavior and inter-subjective interactions. Cooperation and competition, in particular, can be considered as a social interaction between two or more agents who intend to facilitate, but also obstruct, others goal achievement. This paper aims to analyze team neurodynamics during cooperative and competitive interactions.

This study set out to analyze team neurodynamics during cooperative and competitive interaction with  EEG in four directions: (1) analyzing to what extent are neural synchronization measurements robust to the noise; (2) analyzing team neurodynamics based on different neural synchrony measurements (3) explaining neural synchrony in graph theory (4) relating team neurodynamics with team performance. 

18 subjects (9 pairs) participated in the experiment, playing competitive and cooperative computer pong games in dyads with EEG. Five functional connectivity methods were applied to quantify neural synchronies: intersite phase clustering, phase lag index, spectral coherence, power correlation and mutual information. Team brain networks were generated based on intra- and inter-brain neural synchrony. Topological properties of brain networks, which include small-world-ness, global efficiency and betweenness centrality, were calculated to quantify team neurodynamics.

The results show that: 
1. With regard to robust of neural synchrony measurements: mutual information is very sensitive to noise; power-correlation is the least noise-sensitive NS measurement; phase-lag-index can lose some significant neural synchronies; intersite phase clustering and spectral-coherence have similar sensitivity to white noise; 
2. Intra-brain neural synchronization shows prefrontal and parastriatel were highly activated on cooperation and competition; 
3. Neural synchrony is unstable over frequency and fluctuate dramatically over time; 
4. Inter-brain synchrony on cooperation is slightly stronger than interpersonal synchrony on competition; 
5. Inter-brain synchrony does not highly correlate with team-performance; 
6.  Intra-brain network exchange information more efficient than team-brain network; 
7.  Individual brain exchanges information more efficient on competition as compared with cooperation; 
8. Individual brain network has more clusters on cooperation as compared with competition; 
9. Team-brain network has more cluster as compared with individual-brain network; 
10. Global efficiency and small-world-ness of brain networks are relatively unstable over time and relatively stable over frequency; 
11.  Small-world-ness of intersite-phase-clustering-based networks has large variance;
12. Brain hubs changes over time; 
13. Statistically significant INS between cooperation and competition dynamically changes over time, frequency and among different neural synchrony measurements.

This research has many limitations. As regards the experiment, pong-game can not perfectly imitate cooperation and competition; dyads are acquaintances instead of close friends; experiments were not conducted in a quiet environment; there was no baseline experiment in this research to compare cooperative or competitive scenario as neural patterns may be not elicited by cooperation or competition. With
regard to methodologies: only one arbitrary frequency band (beta) was applied in this study instead of multiple frequency bands, while results showed that neural synchrony is unstable over frequency; data were averaged over time while neural synchrony fluctuates dramatically over time; there are many variance definitions of the topological properties (s.t., brain hubs could be measured by betweenness centrality or degree centrality), but this research only applied one definition by time constraint.

In the future work, experiments could be redesigned to better imitate cooperative and competitive interactions. More subjects (close friends) could be recruited with similar age. Results could be analyzed over time or frequency instead of averaging on time and frequency. Baseline experiments could be conducted (in human-tomachine setting or the same game setting without social interaction). Topological properties could be calculated based on different definitions. Multi-layer network could be generated in temporal or frequency domain.

## Software Packages 
- EEGLab
- BCT: {Brain Connectivity Toolbox}[https://sites.google.com/site/bctnet/]
- {Easy Plot EEG Brain Network Matlab}[https://nl.mathworks.com/matlabcentral/fileexchange/57372-easy-plot-eeg-brain-network-matlab]
- {SmallWorldNess}[https://github.com/mdhumphries/SmallWorldNess]

## Data 
Data is shared on {Google Drive}[https://drive.google.com/drive/folders/1iOfnVZHHtJ_PpHSq12LXOsmPE9AF9J9J?usp=sharing]

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
    
