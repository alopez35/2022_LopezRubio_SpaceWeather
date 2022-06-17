% function [time, data] = read_dst(filename)
% reads and returns the timestamps as datenums and Dst index data as 
% downloaded from http://wdc.kugi.kyoto-u.ac.jp/ 
% on 26 May 2021 stored in dstoctober2011.txt.
%
% The function supports script plot_Fig1a.m for plotting Figure 1a of Lopez
% Rubio et al., 2022

% See AUTHORS, LICENSE, and README files for additional information.
% Aurora Lopez Rubio
% Illinois Institute of Technology
% alopez35@hawk.iit.edu
% 8 June 2022
 
function [time, data] = read_dst(filename)

    time = [];
    data = [];
    % Store day and dst values for October 2011
    [file] = xlsread(filename);
    udd = file(:,1); % Unique day
    dst = file(:,2:25); % Dst for each [day x UT hour]
    
    % Create UT hour vector 
    uhh = linspace(0,23,24)'; % HUT hour vector
    
    % Convert Dst matrix [day x UT hour] into vectors [time x 1]; where
    % time will be given in datenum
    dst = reshape(dst',numel(dst),1); 
    
    % Transform day and hour into vectors [time x 1]
    [mdd,mhh] = meshgrid(udd,uhh);
    dd = reshape(mdd,numel(mdd),1);
    hh = reshape(mhh,numel(mhh),1);

    % Create time vector in datenum for October 2011
    time = datenum(dd.*0+2011,dd.*0+10,dd,hh,0,0);
    data = dst;
 
    fclose('all');    
 
end