% This script plots Figures 3, 4 and 5 of Lopez Rubio et al., 2022.
% It plots EMPIRE estimations fro both cases studied in the paper, Case VSH
% and Case PS in FPI LOS neutral winds in m/s. The results are also 
% compared to the model values and FPI measurement values.
%
% The following Matlab warning may arise and was ignored by authors.
% Warning: Ignoring extra legend entries. 
%   In legend>set_children_and_strings (line 629)
%   In legend>make_legend (line 321)
%   In legend (line 247)
%   In plot_Figs345 (line 171) 
%
% See AUTHORS, LICENSE, and README files for additional information.
% Aurora Lopez Rubio
% Illinois Institute of Technology
% alopez35@iit.edu
% 10 June 2022

% Clear and set paths
clear
close all
addpath([cd '/data']);
addpath([cd '/scripts']);

% Select Figure to plot by commenting/uncommenting.
   % Figure 3 Pisgah FPI
% datacase = 'Pisgah_20111025';
 % Figure 3 Cariri FPI
% datacase = 'Cariri_20111025';
 % Figure 3 Nazca FPI
 datacase = 'Nazca_20111025';

% Load data (EMPIRE results for Case VSH and PS, FPI data and HWM14 wind
% values projected into the available FPI LOS).
% Variables loaded description:
    % time{los} = datenum time vector over studied period in LOS.
    % long_wind_meas{los} = structure with FPI measurements over each.
        % avaiable LOS. Formed by following variables:
            % vel = neutral wind measurements projected into los.
            % time = time of the neutral wind measurements.
            % err = neutral wind measurement error.
            % elevation = in deg of los.
            % azimuth = in def of los.
    % fpi_site = string indicating FPI site (Cariri, Pisgah or Nazca).
    % nfpisites = number of LOS available.
    % lon_empire = in deg of intersection between LOS and  h= 250km,
        % where empire results and HWM14 values are plotted.
    % lat_empire = in deg of intersection between LOS and  h= 250km,
        % where empire results and HWM14 values are plotted.
    % us_gLOS_VSH{los} = neutral winds EMPIRE Case VSH estimation in LOS over time.
    % us_gLOS_PS{los} = neutral winds EMPIRE Case PS estimation in LOS over time.
    % um_gLOS_HWM14{los} = neutral winds HWM14 model values in LOS over time.
    % errus_gLOS_VSH{los} = neutral winds EMPIRE Case VSH error in LOS over time.
    % errus_gLOS_PS{los} = neutral winds EMPIRE Case PS error in LOS over time.
load([cd '/data/' datacase]);

  
% Figure settings are specified, for all the subplots in the Figure. 
    % Y limits (neutral windsin  m/s).
vmax = 200;
vmin = -300;

    % X limits (time studied limits in datenum).
tmin =  datenum(str2num(datestr(time{1}(1), 'yyyy')),...
    str2num(datestr(time{1}(1), 'mm')),...
    str2num(datestr(time{1}(1), 'dd')),...
    str2num(datestr(time{1}(1), 'hh')),0,0);
tmax = datenum(str2num(datestr(time{1}(end), 'yyyy')),...
    str2num(datestr(time{1}(end), 'mm')),...
    str2num(datestr(time{1}(end), 'dd')),...
    str2num(datestr(time{1}(end), 'hh'))+1,0,0); 
   
    % Color of the lines in the plot
color_fpi = 'g';
color_empirePS = 'r';
color_empireVSH = 'b';
color_model = 'k';

% Subplots title will indicate the los. Each case will be given a
% caseletter, specified below.
caseletter = {'(a)' '(b)' '(c)' '(d)'};

% Create Figure and figure size.
figure; 
set(gcf,'Units', 'normalized', 'Position', [0.1, 0.1, 0.95, 0.95],'MenuBar','none','ToolBar','none','resize','off') 


% Loop trhough each los and creathe the corresponding subplot in the
% Figure.
for i_los =  1:nfpisites
    % Subplots position is specified depending on the number of LOS
    % available.
    if nfpisites ==4 
        ax(i_los) = subplot(2,2,i_los);
        position_vec = [0.1,0.57, 0.35,0.31
             0.55, 0.57, 0.35,0.31
             0.1,0.12, 0.35,0.31
             0.55,0.12, 0.35,0.31]; 
    elseif nfpisites == 3
        ax(i_los) = subplot(1,nfpisites,i_los);
        position_vec = [0.1,0.12, 0.2,0.76
            0.4, 0.12, 0.2,0.76
            0.7,0.12, 0.2,0.76];
    elseif nfpisites == 2
        ax(i_los) = subplot(1,nfpisites,i_los);
        position_vec = [0.1,0.12, 0.35,0.76
          0.55, 0.12, 0.35,0.76]; 
    end
    set(ax(i_los), 'Units', 'normalized');
    set(ax(i_los), 'Position', position_vec(i_los,:));
    
    % Plot FPI measurements and errors over time.
    eval(['errorbar(long_wind_meas.los' num2str(i_los) ...
        '.time,long_wind_meas.los' num2str(i_los) ...
        '.vel, long_wind_meas.los' num2str(i_los) '.err,''o'',''Color'', color_fpi);'])

    % Plot Case VSH EMPIRE results in the LOS.
    hold on
    errorbar(time{i_los},us_gLOS_VSH{i_los}, errus_gLOS_VSH{i_los}, ...
        'color',color_empireVSH)
    
    % Plot Case PS EMPIRE results in LOS.
    errorbar(time{i_los},us_gLOS_PS{i_los}, errus_gLOS_PS{i_los}, ...
        'color',color_empirePS)

    % Plot HWM14 neutral winds in LOS.
    plot(time{i_los},um_gLOS_HWM14{i_los}, '--', ...
        'color',color_model,'LineWidth',2)
    
    % Set subfigure limits.
    xlim(ax(i_los),[tmin tmax])
    ylim(ax(i_los),[vmin vmax])
    
    % Obtain corresponding elevation and azimuth angles of the LOS.
    el = eval(['long_wind_meas.los' num2str(i_los) '.elevation(1)']);
    az = eval(['long_wind_meas.los' num2str(i_los) '.azimuth(1)']);
    
    % Set subfigure title.
    title_text = [caseletter{i_los} ' Neutral Winds in LOS direction:' char(10) 'Elevation = '...
        num2str(round(el)) ' and Azimuth = ' num2str(round(az)) ' deg'];
    title(title_text, 'fontsize',12)
    
    % Set Y axis.
        % Y label.
    ylabel('[m/s]')
        % Y limits.
    ylim(ax(i_los),[vmin vmax])
    
    % Set X axis.
        % Define and set x ticks depending on the number of LOS available
    if nfpisites == 2
        xticks_defined = linspace(tmin, tmax, 12);
    elseif nfpisites == 3
        xticks_defined = linspace(tmin, ...
            datenum(str2num(datestr(time{i_los}(end), 'yyyy')),...
            str2num(datestr(time{i_los}(end), 'mm')),...
            str2num(datestr(time{i_los}(end), 'dd')),...
            str2num(datestr(time{i_los}(end), 'hh')), 0, 0), 6);
    elseif nfpisites == 4
        xticks_defined = linspace(tmin, ... 
            datenum(str2num(datestr(time{i_los}(end), 'yyyy')),...
            str2num(datestr(time{i_los}(end), 'mm')),...
            str2num(datestr(time{i_los}(end), 'dd')),...
            str2num(datestr(time{i_los}(end), 'hh'))+2, 0, 0), 5);
    end
    set(ax(i_los),'XTick', xticks_defined)
    datetick(ax(i_los),'x','HH','keepticks')
    set(ax(i_los),'XTickLabelRotation',0);
        % Set X label.
    xlabel(ax(i_los),[datestr(time{i_los}(1),'dd mmmm yyyy'), ' at Hour [UTC]'])
        % Set X limits.
    xlim(ax(i_los),[tmin tmax])   
    
    % Figure settings
    grid(ax(i_los),'on')
    set(gca,'fontsize', 12)
    
    % Figure legend
    legend(gca,fpi_site, ['EMPIRE VSH at ',...
        num2str(lat_empire(i_los)), ...
        '^o N ', num2str(lon_empire(i_los)), '^o E'], ...
        ['EMPIRE PS at ',...
        num2str(lat_empire(i_los)), ...
        '^o N ', num2str(lon_empire(i_los)), '^o E'], ...
        ['HWM14 at ', num2str(lat_empire(i_los)), ...
        '^o N ', num2str(lon_empire(i_los)), '^o E'], ...
        'Location','best', 'AutoUpdate','off');
end