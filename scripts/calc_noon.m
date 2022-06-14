% Function calc_noon(hr, min, sec) outputs the latitude and longitude in
% geographic coordinates of the noon line for a given UT time (given by
% inputs hour hr, minute min and second sec).
% This function supports script plot_Fig1b.m for reproducing Figures 1b of
% Lopez et al., (2022)
%
% See AUTHORS, LICENSE, and README files for additional information.
% Aurora Lopez Rubio
% Illinois Institute of Technology
% alopez35@hawk.iit.edu
% 10 June 2022



function [noon_lat, noon_lon] = calc_noon(hr, min, sec)
    % Reference for 0 UT
    zero_line = 180;

    % Time given by UT hr min and sec is transformed to degrees
    hr_space = 360/24;
    min_space = hr_space/60;
    sec_space = min_space/60;
    lon = zero_line - hr*hr_space - min*min_space - sec*sec_space;
    
    % Coordinates of local noon for all latitudes
    noon_lat = -90:10:90;
    noon_lon = zeros(size(noon_lat))+lon;
end
