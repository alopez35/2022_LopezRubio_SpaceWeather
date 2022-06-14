# 2022_LopezRubio_SpaceWeather
Scripts and plotting data for reproducing plots in Space Weather publication Lopez Rubio et al., (2022).
 
This package includes the scripts and files for reproducing the plots (or subplots) in the paper A. Lopez Rubio and S. Datta-Barua (2022), Vector spherical harmonics for data-assimilative neutral wind estimation, Space Weather.
 
Specifically: 
plot_Fig1.m -> Figure 1

plot_Figs345.m -> Figures 3, 4 and 5
 
There is no script to generate Figure 2, which is a cartoon produced in Microsoft Powerpoint and contains no data or processing. 

The package requires the use of Matlab.
 
It has been tested on Matlab R2015b on: "CentOS Linux" and on Matlab R2020b on : "Intel(R) Core(TM) i7-1065G7"
 
Unzipping the package will produce a folder containing the above listed scripts in the top level; support scripts are located in a folder 'scripts', and the data to be plotted are in a folder 'data.'
 
After unzipping the package, preserve the directory structure of the package of plotting scripts in order for the script to run and find the necessary files.  Run the scripts directly with the top level directory as the Matlab working directory.  
 
Each plot*.m will automatically clear all variables and close all figures. The scripts plot_Fig1.m and plot_Figs345.m will automatically add the subdirectories of the package to the Matlab path.  Comment the relevant lines at the start of each script if these behaviors are not desired.  
 
Point of contact:
Aurora López Rubio, Illinois Institute of Technology
alopez35@hawk.iit.edy
http://apollo.tbc.iit.edu/~spaceweather/live/
Created 14 June 2022
