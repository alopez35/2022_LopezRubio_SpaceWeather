
% This script plots Figure 1a of Lopez Rubio et al., 2022.
% It plots Final Dst data vs time.
% The Dst data are in a file dstoctober2011.xlsx copied and pasted
% from http://wdc.kugi.kyoto-u.ac.jp/dst_final/201110/index.html on
% 26 May 2021.
%
% See AUTHORS, LICENSE, and README files for additional information.
% Aurora Lopez Rubio
% Illinois Institute of Technology
% alopez35@iit.edu
% 8 June 2022
 
function fig1a = plot_Fig1a()
 
    % Set time of interest as UTC start and end 
    % [year, month, day, hour, minute, second].
    t0 = [2011 10 24 12 0 0];
    tf = [2011 10 26 0 0 0];

    % Gather provisional Dst data.
    filename = 'data/dstoctober2011.xlsx';
    [time0, dst0] = read_dst(filename);

    % Use only times inside time of interest (t0,tf).
    time = time0(time0>=datenum(t0) & time0 <=datenum(tf));
    dst = dst0(time0>=datenum(t0) & time0 <=datenum(tf));

    % Plot the Dst data.
    h = plot(time, dst);

    % Set time of study time as UTC start and end 
    % [year, month, day, hour, minute, second].
    t1 = [2011 10 25 0 0 0];
    t2 = [2011 10 25 11 0 0];

    % Plot study time limits.
    hold on;
    plot(linspace(datenum(t1),datenum(t1),100), linspace(min(dst)-5,max(dst)+5,100), '--k');
    plot(linspace(datenum(t2),datenum(t2),100), linspace(min(dst)-5,max(dst)+5,100), '--k');


    % Find start of storm time, when dst becomes for the first time smaller 
    % than -30 nT.
    % First, interpolate to obtain more points of dst data in the time of interest
    time_i = (time(1):0.001:time(end))';
    dst_i = interp1(time, dst, time_i);
    % Then, find time when dst becomes smaller than -30 nT.
    ind_startstorm = 1;
     for i=1:length(time_i)
        if abs((dst_i(i) - (-30))) < 1
            ind_startstorm = i;
            break
        end
     end
    % Plot start of storm time.
    tstormut= linspace(time_i(ind_startstorm),time_i(ind_startstorm),100);
    plot(linspace(time_i(ind_startstorm),time_i(ind_startstorm),100), ...
        linspace(min(dst)-5, max(dst)+5,100),'-.g')
    % Indicate the time on the figure.
    text(time_i(ind_startstorm-110),-40,[datestr(time_i(ind_startstorm),'HH'),'UT'],'Color','g')

    fig1a = gcf;
end
   
