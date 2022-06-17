% Function plot_tec_map(ax, teclon, teclat, TEC, colormax, colorlabel) plots a
% map of the world and colors the map with data field TEC (total electron content).
% This function supports script plot_Fig1b.m for reproducing Figures 1b of
% Lopez et al., (2022)
%
% It requires the TEC data, assumed to be from files TEC_yymmdd.mat.
%
% See AUTHORS, LICENSE, and README files for additional information.
% Aurora Lopez Rubio
% Illinois Institute of Technology
% alopez35@hawk.iit.edu
% 8 June 2022
 
function h = plot_tec_map(teclon, teclat, TEC, coords, noon_lat, ...
    noon_lon)

    % Load world coordinates
    load mapdata.mat
    ax = [-180 180 -90 90];
    axis(ax);
    axis image


    % Set colormap of TEC maps
    colormap('parula');
    H =  colormap;

    % Create lon and lat grid
    tri = delaunay(teclon, teclat);

    % Plot colormap TEC
    hold on
    for idx = 1:length(tri)
            v = [teclon(tri(idx,:)) teclat(tri(idx,:))];
            f = [1 2 3];
            patch('faces',f,'vertices',v, 'FaceVertexCData',(TEC(tri(idx,:))),'FaceColor','interp','EdgeColor', 'none')
    end

    % Plot terminator line.
    plot(coords(:,1), coords(:,2), 'k-');

    % Plot noon line
    plot(noon_lon, noon_lat, 'r--');

    % Plot world map
    plot(ll_world(:,2),ll_world(:,1),'k','LineWidth', 2.0); 
    
    % Plot FPI sites
        % FPI Cariri
    plot(-82,35,'ms', 'MarkerFaceColor','m','markersize',8); 
        % FPI Nazca
    plot(-38.56,-6.9,'mp', 'MarkerFaceColor','m','markersize',8);
        % FPI Pisgah
    plot(-75,-15,'m^', 'MarkerFaceColor','m','markersize',8)
end