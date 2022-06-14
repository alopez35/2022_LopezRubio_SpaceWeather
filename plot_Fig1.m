% This script plots Figure 1 of Lopez Rubio et al., 2022.
%
% See AUTHORS, LICENSE, and README files for additional information.
% Aurora Lopez Rubio
% Illinois Institute of Technology
% alopez35@iit.edu
% 8 June 2022

% Clear and set paths
clear
close all
addpath([cd '/data']);
addpath([cd '/scripts']);

% Get Fig 1a (Dst index vs time)
fig(1) = plot_Fig1a();

% Get each of the subplots of Fig 1b (TEC maps at specific times)
% Specificy interest times of TEC maps.
t{1} = 0;
t{2} = 3;
t{3} = 6;
t{4} = 9;
fig(2) = plot_Fig1b(t{1});
fig(3) = plot_Fig1b(t{2});
fig(4) = plot_Fig1b(t{3});
fig(5) = plot_Fig1b(t{4});

% Fig1b settings.
    % Axis limits.
    ax = [-180 180 -90 90];
    % Colorbar limits
    cmax = 60;  cmin = 0;

% Create new figure Fig1 that contains Fig1a and Fig1b
Fig1 = figure('DefaultTextFontName', 'Times', 'DefaultAxesFontName', 'Times');

% Specificy position of each of the subplots of Figure 1.
position = [0.12,0.05+0.1*2+0.275*2, 0.8,0.15
    0.13,0.05+0.1+0.275, 0.4,0.275
    0.55, 0.05+0.1+0.275, 0.4,0.275
    0.13,0.1,0.4,0.275
    0.55,0.1, 0.4,0.275
    ];
%set(gcf,'Units', 'Inches', 'Position', [0.1, 0.1, 10, 11],'MenuBar','none','ToolBar','none','resize','off') 
set(gcf,'Units', 'normalized', 'Position', [0.1, 0.1, 0.9, 0.9],'MenuBar','none','ToolBar','none','resize','off') 

for i=1:5
    % Create different subplots in Fig1
     if i ==1
        h(i) = subplot(3,2,i);
     else
        h(i) = subplot(3,2,i+1); 
     end
     
     % Fig1 settings.
      set(h(i), 'Units', 'normalized');
      set(h(i), 'Position', position(i,:));
      set(gca,'units','points');
             
     % Copy Fig(i) into Fig(6)
     copyobj(allchild(get(fig(i),'CurrentAxes')),h(i));
     
     % Close Fig(i)
     close(fig(i))
     
     % Fig1a settings.
     if i ==1
        % Figure limits.
        axis([datenum(2011,10,24,12,0,0) datenum(2011,10,26,0,0,0) -150 25])
        datetick('x','dd/hh','keeplimits','keepticks')
        XTickLabelRotation = 0;

        % Figure settings.
        grid on
        
        % Figure labels.
        xlabel('Day/UT Hour of October 2011' ,'units','points','fontsize', 14, 'fontname', 'Times')
        ylabel('Dst index [nT]','units','points','fontsize', 14, 'fontname', 'Times')
        title(['(a): DST index 24-25 October 2011'],'units','points','fontsize', 14, 'fontname', 'Times');
     end
    
     % Figu1b settings
     if i>=2
         % Colorbar color
        set(gcf, 'Color', [1 1 1])
         % Title
         title([num2str(t{i-1}) ' UT'],'units','points','fontsize', 14, 'fontname', 'Times');
         if i == 2
             title(['(b): ' num2str(t{i-1}) ' UT'],'units','points','fontsize', 14, 'fontname', 'Times');
         end
         % Specifiy axis and colormap
         axis(ax);colormap('default'); set(gca, 'CLim', [cmin cmax]);
         if i==2 || i==3
            set(gca,'XTick',[])
         end
         if i==2||  i==4
            H = colorbar;
            ylabel(['Geographic Latitude' char(10) '[deg N]'],'units','points','fontsize', 14, 'fontname', 'Times');
         end
         if i== 4 || i== 5
            xlabel(['Geographic Longitude [deg E]'],'units','points','fontsize', 14, 'fontname', 'Times'); 
         end
         if i==3 ||  i==5
            H = colorbar;
            set(get(H,'Ylabel'),'String',['Vertical TEC' ' [TECU]'],'units','points','fontsize', 14, 'fontname', 'Times');
            set(gca,'YTick',[])
         end
     end
     set(gca,'Fontsize',14,'Fontname', 'Times');
    
end

    
    


