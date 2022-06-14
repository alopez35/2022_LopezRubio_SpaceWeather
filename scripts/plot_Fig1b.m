% This script plots of Figure 1b of Lopez Rubio et al., 2022
%
% It plots maps of IDA4D output ionospheric electron densities, vertically 
% integrated as total electron content.
%
% The IDA4D TEC data are in files  TEC_yymmdd.mat and were created
% from the outputs of the study shown in Lopez Rubio et al., 2022.
%
% It uses plotdaynightterminator.m function: from Centre for Advanced 
% Internet Architectures Swinburne University of Technology, Melbourne,
% Australia (CRICOS number 00111D) Copyright (c) 2009-2012.
%
% The following Matlab warning may arise and was ignored by authors.
% "Warning: MATLAB has disabled some advanced graphics rendering features 
% by switching to software OpenGL. For more information, click here."

%
% See AUTHORS, LICENSE, and README for additional information.
% Aurora Lopez Rubio
% Illinois Institute of Technology
% alopez35@hawk.iit.edu
% 8 June 2022
 
function figb = plot_Fig1b(t)
    % t = hour of the day of interested time

    % Load TEC data from TEC_yymmdd.mat files
    load(['data/TEC_' datestr(datenum(2011,10,25,t,0,0), 'yymmdd') '.mat']);
    % loads TEC, lon, lat, time

    % Transform lon to (-180,180)
    lon = reshape(lon, numel(lon), 1);
    for k = 1:numel(lon)
        if lon(k)>180
            lon(k) = lon(k)-360;
        end
    end

    % Convert to double
    lon= double(lon);
    lat=double(lat);
    TEC=double(TEC);

    % Putting tec in units of TECU
    [tf, ti] = ismember(t, time);
    tec = squeeze(TEC(:,ti));
    tec = tec/(10^16); 

    % Obtain terminator line
    coords = plotdaynightterminator(25, 10, 2011, floor(t), (t - floor(t))*60, 0);

    % Obtain noon line
    [noon_lat, noon_lon] = calc_noon(t, (t-floor(t))*60, 0);

    % Plot TECmap figure
    figure
    plot_tec_map( lon, lat, tec, coords, noon_lat, noon_lon);
    figb = gcf; 
end