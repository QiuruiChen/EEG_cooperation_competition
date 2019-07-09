clear all; close all; clc;
load('D:\work\eeg\2PersonPongGame\data/useful/conn/conn_power','conn_power');
compet_power_smallworld_adjacencyMatrix = mean(conn_power.compet.beta,2)';
save('compet_power_smallworld_adjacencyMatrix','compet_power_smallworld_adjacencyMatrix');
cop_power_smallworld_adjacencyMatrix = mean(conn_power.cop.beta,2)';
save('cop_power_smallworld_adjacencyMatrix','cop_power_smallworld_adjacencyMatrix');
%  phase: ispc 
clear all; close all; clc;
load('D:\work\eeg\2PersonPongGame\data/useful/conn/conn_phase_ispc','conn_phase_ispc');
compet_ispc_smallworld_adjacencyMatrix = mean(conn_phase_ispc.compet.beta,2)';
save('compet_ispc_smallworld_adjacencyMatrix','compet_ispc_smallworld_adjacencyMatrix');
cop_ispc_smallworld_adjacencyMatrix = mean(conn_phase_ispc.compet.beta,2)';
save('cop_ispc_smallworld_adjacencyMatrix','cop_ispc_smallworld_adjacencyMatrix');
% phase: pli
clear all; close all; clc;
load('D:\work\eeg\2PersonPongGame\data/useful/conn/conn_phase_pli','conn_phase_pli');
compet_pli_smallworld_adjacencyMatrix = mean(conn_phase_pli.compet.beta,2)';
save('compet_pli_smallworld_adjacencyMatrix','compet_pli_smallworld_adjacencyMatrix');
cop_pli_smallworld_adjacencyMatrix = mean(conn_phase_pli.cop.beta,2)';
save('cop_pli_smallworld_adjacencyMatrix','cop_pli_smallworld_adjacencyMatrix');
% phase: specoher
clear all; close all; clc;
load('D:\work\eeg\2PersonPongGame\data/useful/conn/conn_phase_spectcoher','conn_phase_spectcoher');
compet_spectcoher_smallworld_adjacencyMatrix = mean(conn_phase_spectcoher.compet.beta,2)';
save('compet_power_smallworld_adjacencyMatrix','compet_spectcoher_smallworld_adjacencyMatrix');
cop_spectcoher_smallworld_adjacencyMatrix = mean(conn_phase_spectcoher.cop.beta,2)';
save('cop_spectcoher_smallworld_adjacencyMatrix','cop_spectcoher_smallworld_adjacencyMatrix');