function topoplotNode(nch, ijw, w_scal,brainNum)
if (brainNum == 2)
    w_atribut = ijw(:,2);              %taking the weights' attributes
    w_scaling = w_scal;                 %taking the scaling of weigths
    n_atribut = ijw(:,2);           %fixing nodes' attributes
    n_scaling = 'n_nn2nx';              %fixing nodes' scaling
    cbnet = 'nocb';                     %fixing not to show the colorbars
    load('D:\work\eeg\2PersonPongGame\f_PlotEEG_BrainNetwork\easycapM11.mat') %(lay struct) provided from EasyCap Enterprises.
    load('D:\work\eeg\2PersonPongGame\f_PlotEEG_BrainNetwork\labelsEEG2.mat') %cell array of 4 desired layouts of nodes (made by myself)

    if ~exist('binNum','var')
        binNum = 0;  % without direction
    end 
    nchannels = nch;            % number of channels defines the position layout 
    labels = labelsEEG{1};      %labels of a 21 montage
    % % % comparing desired labels with original general labels
    [~,b] = (ismember(labels, lay.label));   %b are the desired nodes' indexes from the gral layout
    r_nodepos = lay.pos(b, :);      %position of desired nodes depending on the layout
    r_nodepos2 = horzcat(r_nodepos(:,1)+2,r_nodepos(:,2));
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

    switch w_scaling
        case 'w_intact'   % keep weights intact
            w_atribut_new = w_atribut;
        case 'w_unity'    % scaling weights to unity
            w_atribut_new = w_atribut./max(w_atribut);
        case 'w_wn2wx'     % scaling between wn to wx (default wn=1, wx=10)
            wn = 1;
            wx = 5;
            w_atribut_new = wn + (((w_atribut - min(w_atribut))*(wx-wn))/(max(w_atribut) - min(w_atribut)));
        otherwise
            error('type w_scaling as: ''w_intact'' or ''w_unity'' or ''w_wn2wx''')
    end
    % % % associating weight's attributes to inversed colormap BONE
    RGBlinks = squeeze(double2rgb(w_atribut_new, flipud(colormap(bone))));

    switch n_scaling
        case 'n_fixed'
            fixedsizenode = 2;
            n_atribut_new = n_atribut.*0 + fixedsizenode;
            % % % associating equal nodes' attributes to ONE color
            RGBnodes = squeeze(double2rgb(n_atribut_new, colormap([210,180,28]./255)));
        case 'n_nn2nx'          % scaling between nn to nx (default nn=1, nx=10)
            nn = 0;
            nx = 10;
            n_atribut_new = nn + (((n_atribut - min(n_atribut))*(nx-nn))/(max(n_atribut) - min(n_atribut)));
            % % % associating nodes' attributes to colormap JET
            RGBnodes = squeeze(double2rgb(n_atribut_new, colormap(jet)));
        otherwise
            error('type n_scaling as: ''n_fixed'' or ''n_nn2nx''')
    end
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

    % % % % % % % % % % % % % %  STARTING TO DISPLAY THE FIGURE  % % % % % % % % % %
    % axis square;                                    %making it squared
    pbaspect([2.2 1 1]);
    axis off;                                       %avoiding the axis
    % % % Put here the line (EXPANDING FIGURE ON SCREEN) if you want to see an
    % animation version when activate the line (PAUSE(.1))
    % % % :::::::::::::::::::::::::::::: PLOTTING HEAD :::::::::::::::::::::::::::
    hold on;
    % % % plotting head layout, the first person 
    plot(lay.outline{1}(:,1), lay.outline{1}(:,2), 'k', 'LineWidth',4)
    plot(lay.outline{1}(:,1), lay.outline{1}(:,2), 'g', 'LineWidth',2, 'color', [119,136,153]./255)
    plot(lay.outline{2}(:,1), lay.outline{2}(:,2), '--k', 'LineWidth',4)
    plot(lay.outline{2}(:,1), lay.outline{2}(:,2), 'g', 'LineWidth',2, 'color', [119,136,153]./255)
    plot(lay.outline{3}(:,1), lay.outline{3}(:,2), '--k', 'LineWidth',4)
    plot(lay.outline{3}(:,1), lay.outline{3}(:,2), 'g', 'LineWidth',2, 'color', [119,136,153]./255)
    plot(lay.outline{4}(:,1), lay.outline{4}(:,2), '--k', 'LineWidth',4)
    plot(lay.outline{4}(:,1), lay.outline{4}(:,2), 'g', 'LineWidth',2, 'color', [119,136,153]./255)
    % % % plotting head layout, the second person 
    plot(lay.outline{1}(:,1)+2, lay.outline{1}(:,2), 'k', 'LineWidth',4)
    plot(lay.outline{1}(:,1)+2, lay.outline{1}(:,2), 'g', 'LineWidth',2, 'color', [119,136,153]./255)
    plot(lay.outline{2}(:,1)+2, lay.outline{2}(:,2), '--k', 'LineWidth',4)
    plot(lay.outline{2}(:,1)+2, lay.outline{2}(:,2), 'g', 'LineWidth',2, 'color', [119,136,153]./255)
    plot(lay.outline{3}(:,1)+2, lay.outline{3}(:,2), '--k', 'LineWidth',4)
    plot(lay.outline{3}(:,1)+2, lay.outline{3}(:,2), 'g', 'LineWidth',2, 'color', [119,136,153]./255)
    plot(lay.outline{4}(:,1)+2, lay.outline{4}(:,2), '--k', 'LineWidth',4)
    plot(lay.outline{4}(:,1)+2, lay.outline{4}(:,2), 'g', 'LineWidth',2, 'color', [119,136,153]./255)
    % % % plotting links and nodes
    for lk = 1 : size(ijw, 1)           %along all links
        if ijw(lk,1) > 21
            xynodes = r_nodepos2(ijw(lk,1)-21, :);
        else
            xynodes = r_nodepos(ijw(lk,1), :);  % for the first node of the link, hold the positions
        end

        nd = 1;                          
        if ijw(lk,1) > 21 % for one node
    %   line(xynodes(nd, 1), xynodes(nd, 2), 'o', 'MarkerSize', 5*pi.*n_atribut_new(ijw(lk,nd)-21), ...
    %                 'MarkerEdgeColor','k', 'MarkerFaceColor', RGBnodes(ijw(lk,nd)-21, :), 'LineWidth',1.5,'MarkerFaceAlpha',0.2);
            if (n_atribut_new(ijw(lk,nd)-21) ~= 0)
                circles(xynodes(1), xynodes(2), n_atribut_new(ijw(lk,nd))/100, ...
                    'edgecolor','k', 'facecolor', [.5 .5 .1], 'linewidth',1.5);
                text(xynodes(nd, 1)-0.01, xynodes(nd, 2)-0.01, labels{ijw(lk,nd)-21}, 'fontsize', 15);
            end
        else
    %    line(xynodes(nd, 1), xynodes(nd, 2), 'o', 'MarkerSize', 5*pi.*n_atribut_new(ijw(lk,nd)), ...
    %                 'MarkerEdgeColor','k', 'MarkerFaceColor', RGBnodes(ijw(lk,nd), :), 'LineWidth',1.5,'MarkerFaceAlpha',0.2);
            if (n_atribut_new(ijw(lk,nd)) ~= 0)
                circles(xynodes(1), xynodes(2),n_atribut_new(ijw(lk,nd))/100, ...
                    'edgecolor','k','facecolor',[.5 .5 .1],'linewidth',1.5);            
                text(xynodes(nd,1)-0.01, xynodes(nd, 2)-0.01, labels{ijw(lk,nd)}, 'fontsize', 15);
            end
        end

        %         pause(.1)

    %     line(xynodes(:, 1), xynodes(:, 2), 'LineWidth', w_atribut_new(lk), 'Color', [.5 .5 .1] );
    %         line(xynodes(:, 1), xynodes(:, 2), 'LineWidth', ijw(lk, 3), 'Color', RGBlinks(lk, :)); % links de un solo color

    end
    set(gca,'XTick',[],'YTick',[]);     %avoiding the tick labels of axis
    axis tight;                         %setting axis limits to the range of data
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

    % % % % % % % % % % % % % % % % %  CODIFYING THE DOUBLE COLORMAPS AND COLORBARS
    ax1 = gca;                          %getting current axis of figure
    if strcmp(cbnet, 'nocb')
        display('Nodes scaling is fixed')
    elseif strcmp(cbnet, 'wcb')
        % % % % LINKS
        cm2 = colormap(bone);
        cm2 = flipud(cm2);              %inverting colorbar axis
        colormap(cm2);
        cb2 = colorbar('Location', 'west', 'fontsize', 30);
        caxis([min(w_atribut) max(w_atribut)]);
        cbfreeze(cm2)                   %freezing this colormap
        freezeColors;                   %freezing this colorbar
    elseif strcmp(cbnet, 'ncb')
        % % % % NODOS
        cm1 = colormap(jet);
        cb1 = colorbar('Location', 'east', 'fontsize', 30);
        caxis([min(n_atribut(n_atribut>0)) max(n_atribut)]);%taking the nodes' attributes different from zero
        cbfreeze(cm1)
        freezeColors(ax1)
    elseif strcmp(cbnet, 'wncb')
        % % % % NODOS
        cm1 = colormap(jet);
        cb1 = colorbar('Location', 'east', 'fontsize', 30);
        caxis([min(n_atribut(n_atribut>0)) max(n_atribut)])
        cbfreeze(cm1)
        freezeColors(ax1)
        % % % % LINKS
        cm2 = colormap(bone);
        cm2 = flipud(cm2);
        colormap(cm2);
        cb2 = colorbar('Location', 'west', 'fontsize', 30);
        caxis([min(w_atribut) max(w_atribut)])
        cbfreeze(cm2)
        freezeColors
    else
        error('type cbnet as: ''nocb'', ''wcb'', ''ncb'', ''wncb''');
    end
    hold off;
    set(gcf, 'units','normalized','outerposition',[0 0 1 1]) %EXPANDING FIGURE ON SCREEN
else
% ========================================================================
% only for one brain 
% ========================================================================
        w_atribut = ijw(:,2);              %taking the weights' attributes
    w_scaling = w_scal;                 %taking the scaling of weigths
    n_atribut = ijw(:,2);           %fixing nodes' attributes
    n_scaling = 'n_nn2nx';              %fixing nodes' scaling
    cbnet = 'nocb';                     %fixing not to show the colorbars
    load easycapM11.mat  %(lay struct) provided from EasyCap Enterprises.
    load labelsEEG2.mat %cell array of 4 desired layouts of nodes (made by myself)

    if ~exist('binNum','var')
        binNum = 0;  % without direction
    end 
    nchannels = nch;            % number of channels defines the position layout 
    labels = labelsEEG{1};      %labels of a 21 montage
    % % % comparing desired labels with original general labels
    [~,b] = (ismember(labels, lay.label));   %b are the desired nodes' indexes from the gral layout
    r_nodepos = lay.pos(b, :);      %position of desired nodes depending on the layout
    r_nodepos2 = horzcat(r_nodepos(:,1)+2,r_nodepos(:,2));
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

    switch w_scaling
        case 'w_intact'   % keep weights intact
            w_atribut_new = w_atribut;
        case 'w_unity'    % scaling weights to unity
            w_atribut_new = w_atribut./max(w_atribut);
        case 'w_wn2wx'     % scaling between wn to wx (default wn=1, wx=10)
            wn = 1;
            wx = 5;
            w_atribut_new = wn + (((w_atribut - min(w_atribut))*(wx-wn))/(max(w_atribut) - min(w_atribut)));
        otherwise
            error('type w_scaling as: ''w_intact'' or ''w_unity'' or ''w_wn2wx''')
    end
    % % % associating weight's attributes to inversed colormap BONE
    RGBlinks = squeeze(double2rgb(w_atribut_new, flipud(colormap(bone))));

    switch n_scaling
        case 'n_fixed'
            fixedsizenode = 2;
            n_atribut_new = n_atribut.*0 + fixedsizenode;
            % % % associating equal nodes' attributes to ONE color
            RGBnodes = squeeze(double2rgb(n_atribut_new, colormap([210,180,28]./255)));
        case 'n_nn2nx'          % scaling between nn to nx (default nn=1, nx=10)
            nn = 0;
            nx = 10;
            n_atribut_new = nn + (((n_atribut - min(n_atribut))*(nx-nn))/(max(n_atribut) - min(n_atribut)));
            % % % associating nodes' attributes to colormap JET
            RGBnodes = squeeze(double2rgb(n_atribut_new, colormap(jet)));
        otherwise
            error('type n_scaling as: ''n_fixed'' or ''n_nn2nx''')
    end
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

    % % % % % % % % % % % % % %  STARTING TO DISPLAY THE FIGURE  % % % % % % % % % %
    axis square;                                    %making it squared
%     pbaspect([2.2 1 1]);
    axis off;                                       %avoiding the axis
    % % % Put here the line (EXPANDING FIGURE ON SCREEN) if you want to see an
    % animation version when activate the line (PAUSE(.1))
    % % % :::::::::::::::::::::::::::::: PLOTTING HEAD :::::::::::::::::::::::::::
    hold on;
    % % % plotting head layout, the first person 
    plot(lay.outline{1}(:,1), lay.outline{1}(:,2), 'k', 'LineWidth',4)
    plot(lay.outline{1}(:,1), lay.outline{1}(:,2), 'g', 'LineWidth',2, 'color', [119,136,153]./255)
    plot(lay.outline{2}(:,1), lay.outline{2}(:,2), '--k', 'LineWidth',4)
    plot(lay.outline{2}(:,1), lay.outline{2}(:,2), 'g', 'LineWidth',2, 'color', [119,136,153]./255)
    plot(lay.outline{3}(:,1), lay.outline{3}(:,2), '--k', 'LineWidth',4)
    plot(lay.outline{3}(:,1), lay.outline{3}(:,2), 'g', 'LineWidth',2, 'color', [119,136,153]./255)
    plot(lay.outline{4}(:,1), lay.outline{4}(:,2), '--k', 'LineWidth',4)
    plot(lay.outline{4}(:,1), lay.outline{4}(:,2), 'g', 'LineWidth',2, 'color', [119,136,153]./255)
    for lk = 1 : size(ijw, 1)           %along all links
        if ijw(lk,1) > 21
            xynodes = r_nodepos2(ijw(lk,1)-21, :);
        else
            xynodes = r_nodepos(ijw(lk,1), :);  % for the first node of the link, hold the positions
        end
        nd = 1;                          
        if ijw(lk,1) > 21 % for one node
        else
           if (n_atribut_new(ijw(lk,nd)) ~= 0)
                circles(xynodes(1), xynodes(2),n_atribut_new(ijw(lk,nd))/100, ...
                    'edgecolor','k','facecolor',[.5 .5 .1],'linewidth',1.5);            
                text(xynodes(nd,1)-0.01, xynodes(nd, 2)-0.01, labels{ijw(lk,nd)}, 'fontsize', 15);
            end
        end
    end
    set(gca,'XTick',[],'YTick',[]);     %avoiding the tick labels of axis
    axis tight;                         %setting axis limits to the range of data
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

    % % % % % % % % % % % % % % % % %  CODIFYING THE DOUBLE COLORMAPS AND COLORBARS
    ax1 = gca;                          %getting current axis of figure
    if strcmp(cbnet, 'nocb')
        display('Nodes scaling is fixed')
    elseif strcmp(cbnet, 'wcb')
        % % % % LINKS
        cm2 = colormap(bone);
        cm2 = flipud(cm2);              %inverting colorbar axis
        colormap(cm2);
        cb2 = colorbar('Location', 'west', 'fontsize', 30);
        caxis([min(w_atribut) max(w_atribut)]);
        cbfreeze(cm2)                   %freezing this colormap
        freezeColors;                   %freezing this colorbar
    elseif strcmp(cbnet, 'ncb')
        % % % % NODOS
        cm1 = colormap(jet);
        cb1 = colorbar('Location', 'east', 'fontsize', 30);
        caxis([min(n_atribut(n_atribut>0)) max(n_atribut)]);%taking the nodes' attributes different from zero
        cbfreeze(cm1)
        freezeColors(ax1)
    elseif strcmp(cbnet, 'wncb')
        % % % % NODOS
        cm1 = colormap(jet);
        cb1 = colorbar('Location', 'east', 'fontsize', 30);
        caxis([min(n_atribut(n_atribut>0)) max(n_atribut)])
        cbfreeze(cm1)
        freezeColors(ax1)
        % % % % LINKS
        cm2 = colormap(bone);
        cm2 = flipud(cm2);
        colormap(cm2);
        cb2 = colorbar('Location', 'west', 'fontsize', 30);
        caxis([min(w_atribut) max(w_atribut)])
        cbfreeze(cm2)
        freezeColors
    else
        error('type cbnet as: ''nocb'', ''wcb'', ''ncb'', ''wncb''');
    end
    hold off;
    set(gcf, 'units','normalized','outerposition',[0 0 1 1]) %EXPANDING FIGURE ON SCREEN
end