function [prop] = cal_network_property(W_nrm)
% degree and similairirty 
prop.degrees = degrees_und(W_nrm); % degrees 
prop.strength = strengths_und(W_nrm); % strength 
prop.density = density_und(W_nrm); % density
prop.cluster = clustering_coef_wu(W_nrm); %clustering coefficient 
prop.transitivity = transitivity_wu(W_nrm); % transitivity
prop.localEff = efficiency_wei(W_nrm); % efficiency
if sum(isnan(W_nrm(:))) > 0
    W_nrm_temp = W_nrm;
    W_nrm_temp(isnan(W_nrm_temp))=0;
    prop.comm_moduality = modularity_und(W_nrm_temp); % combetanity  detection
    prop.eigenvector_centrality = eigenvector_centrality_und(W_nrm_temp); % not work for negative value
    prop.pathLength = charpath(W_nrm_temp);
    prop.firstPassTime = mean_first_passage_time(W_nrm_temp);
    prop.diffusion_eff = diffusion_efficiency(W_nrm_temp);
else
    prop.comm_moduality = modularity_und(W_nrm); % combetanity detection
    prop.eigenvector_centrality = eigenvector_centrality_und(W_nrm); % not work for negative value
    prop.pathLength = charpath(W_nrm);
%     prop.firstPassTime = mean_first_passage_time(W_nrm);
%     prop.diffusion_eff = diffusion_efficiency(W_nrm);
end
if numel(W_nrm(W_nrm<0))==0
    prop.comm_louvain = community_louvain(W_nrm); % not for negative links
    prop.betweenness = betweenness_wei(W_nrm);
    prop.edge_betweenness = edge_betweenness_wei(W_nrm);
end
% prop_corr_power_delta.comm_link = link_comcorr_deltanities(W_nrm);
prop.assortativity = assortativity_wei(W_nrm,0); %0 for undirected graph
prop.hub = rich_club_wu(W_nrm); 
prop.core = core_periphery_dir(W_nrm);
% prop_corr_power_delta.s_score = score_wu(W_nrm, 0.5); % largest subnetwork comprising nodes of strength at least s
prop.distance = distance_wei(W_nrm);
prop.distance_floyd = distance_wei_floyd(W_nrm);

%  efficiency and diffusion 
prop.efficiency = efficiency_wei(W_nrm);

% need the second parameter: D - Symmetric NxN nodal distance matrix (e.g., Euclidean distance between node centroids)
% prop_corr_power_delta.navigation = navigation_wu(W_nrm);  
% centrality 


% need comcorr_deltanity affiliation vector
% prop_corr_power_delta.module_degree_zscore = module_degree_zscore(W_nrm); 
% prop_corr_power_delta.participation_coef = participation_coef(W_nrm);
% prop_corr_power_delta.pagerank_centrality = pagerank_centrality(W_nrm);
%% quasi-idempotence
% prop_corr_power_delta.quasi_idempotence = quasi_idempotence(W_nrm); % not work for negative values 
end