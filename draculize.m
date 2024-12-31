function draculize(varargin)
%Applies the Dracula color theme to the current figure.
%
%OPTIONAL NAME-VALUE PAIRS
% AxesOnly :: Apply theme to the axes only {false (default) | true}
%
%DETAILS
% The Dracula color theme is a stylish dark color theme that is very
% popular in the programming community. With the draculize() function you
% can now apply the Dracula color theme to (most) plots generated in
% MATLAB. (See https://draculatheme.com/contribute#color-palette).
%
%RECOMMENDED USAGE
% This function is recommended if you are already using a dark color theme
% in your MATLAB Desktop App or in MATLAB Online because it will eliminate 
% the bright white background in most of the figures that you make.
% 
%
%EXAMPLES
%Create a simple plot
% x = 1:10;
% y = 1:10;
% plot(x,y)
% draculize
%
%Create a more complex plot
% [X,Y,Z] = peaks;
% contour3(X,Y,Z,20)
% title('3D Contour Plot'), subtitle('Works with subtitles, too.')
% xlabel('X-axis'), ylabel('Y-axis'), zlabel('Z-axis')
% hold on
% 	text(-3.5,-2.5,-2.5,'...and added text!')
% hold off
% draculize(AxesOnly=true)
%
%
%LIMITATIONS
% The draculize function works for most plotting functions, but not all. 
% This is because there are a lot of less-common plot types that, un-
% fortunately, are not very customizable. The draculize function is also
% not recommended for subplots or figures with secondary axes.
%
%
%See also
% dracula_colororder dracula_colormap

%Copyright 2024 Austin M Weber

% Begin main function
    % Parse the user inputs
    p = inputParser;
    defaultAxesOnly = false;
    addParameter(p, 'AxesOnly', defaultAxesOnly, @(x) islogical(x));
    parse(p, varargin{:});
    axesOnly = p.Results.AxesOnly;
    
    if ~axesOnly
        draculize_all
    else
        draculize_axes
    end
% End main function
end

function draculize_axes
% Apply Dracula theme to axes only
    % Import dracula colors
    load("dracula.mat")
    
    % Get figure and axes handles
    f = gcf;
    ax = gca;
    
    % Print a custom error message if the axis class is not compatible with the draculize function
    ax_class = class(ax);
    if contains(ax_class,'StackedLineChart')
	    error('Sorry, the draculize function is not currently compatible with axes of the class StackedLineChart. Try manually updating your figure by using the color palettes in dracula.mat')
    elseif contains(ax_class,'WordCloudChart')
	    error('Sorry, the draculize function is not currently compatible with axes of the class WordCloudChart. Try manually updating your figure by using the color palettes in dracula.mat')
    elseif contains(ax_class,'BubbleCloud')
	    error('Sorry, the draculize function is not currently compatible with axes of the class BubbleCloud. Try manually updating your figure by using the color palettes in dracula.mat')
    elseif contains(ax_class,'ScatterHistogramChart')
	    error('Sorry, the draculize function is not currently compatible with axes of the class ScatterHistogramChart. Try manually updating your figure by using the color palettes in dracula.mat')
    elseif contains(ax_class,'ParallelCoordinatesPlot')
	    error('Sorry, the draculize function is not currently compatible with axes of the class ParallelCoordinatesPlot. Try manually updating your figure by using the color palettes in dracula.mat')
    
    end
    
    if contains(ax_class,'HeatmapChart')
	    error('Sorry, the draculize function is not currently compatible with axes of the class HeatmapChart.')
    end
    
    % Check if polar axes
    pax = findobj(gcf,'Type','PolarAxes');
    if size(pax,1) > 0
	    pax.Color = dracula_rgb_colors(1,:);
	    pax.RColor = dracula_rgb_colors(3,:);
	    pax.ThetaColor = dracula_rgb_colors(3,:);
	    pax.Title.Color = dracula_rgb_colors(3,:);
	    pax.Subtitle.Color = dracula_rgb_colors(3,:);
	    pax.GridColor = dracula_rgb_colors(4,:);
	    set(gcf,'Color',dracula_rgb_colors(1,:))
    
	    % Apply draculize to legend objects
	    legendHandle = findobj(f,'Type','Legend');
	    if ~isempty(legendHandle)
		    for k=1:size(legendHandle,1)
		        legendHandle(k).Color=dracula_hex_colors{1};
		        legendHandle(k).EdgeColor=dracula_hex_colors{3};
		        legendHandle(k).TextColor=dracula_hex_colors{3};
		    end
	    end
	    return
    end
    
    % Check if pie chart
    pie_obj = findobj(gcf,'Type','PieChart');
    if size(pie_obj,1) > 0
        pie_obj.FontColor = dracula_rgb_colors(3,:);
        return
    end
    
    % Check if donut chart
    donut_obj = findobj(gcf,'Type','DonutChart');
    if size(donut_obj,1) > 0
        donut_obj.FontColor = dracula_rgb_colors(3,:);
        return
    end
    
    % Set figure and axes background colors
    f.Color = dracula_hex_colors{1};
    ax.Color = dracula_rgb_colors(1,:);
    
    % Set data label colors
    set(ax,'XColor',dracula_hex_colors{3});
    set(ax,'YColor',dracula_hex_colors{3});
    set(ax,'ZColor',dracula_hex_colors{3});
    
    % Set axis label colors
    ax.Title.Color=dracula_hex_colors{3};
    ax.Subtitle.Color=dracula_hex_colors{4};
    ax.YLabel.Color=dracula_hex_colors{3};
    ax.XLabel.Color=dracula_hex_colors{3};
    ax.ZLabel.Color=dracula_hex_colors{3};
    
    % For box charts
    box_chart_obj = findobj(f,'Type','BoxChart');
    for k = 1:size(box_chart_obj,1)
	    box_chart_obj(k).WhiskerLineColor=dracula_hex_colors{3};
    end
    
    % Apply draculize to legend objects
    legendHandle = findobj(f,'Type','Legend');
    if ~isempty(legendHandle)
	    for k=1:size(legendHandle,1)
            legendHandle(k).Color=dracula_hex_colors{1};
            legendHandle(k).EdgeColor=dracula_hex_colors{3};
            legendHandle(k).TextColor=dracula_hex_colors{3};
	    end
    end
    
    % Apply draculize to colorbar objects
    colorbarHandle = findobj(f,'Type','Colorbar');
    if ~isempty(colorbarHandle)
	    for k=1:size(colorbarHandle,1)
            colorbarHandle(k).Color=dracula_hex_colors{3};
            colorbarHandle(k).TickDirection='out';
            colorbarHandle(k).Label.Color=dracula_hex_colors{3};
	    end
    end
    
    % Apply draculize to text objects
    textHandle = findobj(f,'Type','Text');
    if ~isempty(textHandle)
	    for k=1:size(textHandle,1)
            textHandle(k).Color=dracula_hex_colors{3};
	    end
    end
end

function draculize_all
% Apply Dracula theme to all axes AND update the color order/cmap
    % Import dracula colors
    load("dracula.mat")
    
    % Define colororder (7 total colors)
    co = dracula_rgb_colors(5:end,:);
    
    % Get figure and axes handles
    f = gcf;
    ax = gca;
    
    % Print a custom error message if the axis class is not compatible with the draculize function
    ax_class = class(ax);
    if contains(ax_class,'StackedLineChart')
	    error('Sorry, the draculize function is not currently compatible with axes of the class StackedLineChart. Try manually updating your figure by using the color palettes in dracula.mat')
    elseif contains(ax_class,'WordCloudChart')
	    error('Sorry, the draculize function is not currently compatible with axes of the class WordCloudChart. Try manually updating your figure by using the color palettes in dracula.mat')
    elseif contains(ax_class,'BubbleCloud')
	    error('Sorry, the draculize function is not currently compatible with axes of the class BubbleCloud. Try manually updating your figure by using the color palettes in dracula.mat')
    elseif contains(ax_class,'ScatterHistogramChart')
	    error('Sorry, the draculize function is not currently compatible with axes of the class ScatterHistogramChart. Try manually updating your figure by using the color palettes in dracula.mat')
    elseif contains(ax_class,'ParallelCoordinatesPlot')
	    error('Sorry, the draculize function is not currently compatible with axes of the class ParallelCoordinatesPlot. Try manually updating your figure by using the color palettes in dracula.mat')
    
    end
    
    if contains(ax_class,'HeatmapChart')
	    heatmap_fig = findobj(gcf,'Type','Figure');
	    heatmap_fig.Colormap = dracula_cmap;
	    return
    end
    
    % Check if polar axes
    pax = findobj(gcf,'Type','PolarAxes');
    if size(pax,1) > 0
	    pax.Color = dracula_rgb_colors(1,:);
	    pax.ColorOrder = co;
	    pax.Colormap = dracula_cmap;
	    pax.RColor = dracula_rgb_colors(3,:);
	    pax.ThetaColor = dracula_rgb_colors(3,:);
	    pax.Title.Color = dracula_rgb_colors(3,:);
	    pax.Subtitle.Color = dracula_rgb_colors(3,:);
	    pax.GridColor = dracula_rgb_colors(4,:);
	    set(gcf,'Color',dracula_rgb_colors(1,:))
    
	    % Check if polar histogram
	    phist = findobj(gcf,'Type','Histogram');
	    if size(phist) > 0
		    phist.FaceColor = dracula_rgb_colors(5,:);
	    end
    
	    % Apply draculize to legend objects
	    legendHandle = findobj(f,'Type','Legend');
	    if ~isempty(legendHandle)
		    for k=1:size(legendHandle,1)
		        legendHandle(k).Color=dracula_hex_colors{1};
		        legendHandle(k).EdgeColor=dracula_hex_colors{3};
		        legendHandle(k).TextColor=dracula_hex_colors{3};
		    end
	    end
	    return
    end
    
    % Check if pie chart
    pie_obj = findobj(gcf,'Type','PieChart');
    if size(pie_obj,1) > 0
        pie_obj.ColorOrder = co;
        pie_obj.FontColor = dracula_rgb_colors(3,:);
        return
    end
    
    % Check if donut chart
    donut_obj = findobj(gcf,'Type','DonutChart');
    if size(donut_obj,1) > 0
        donut_obj.ColorOrder = co;
        donut_obj.FontColor = dracula_rgb_colors(3,:);
        return
    end
    
    
    % Set figure and axes background colors
    f.Color = dracula_hex_colors{1};
    ax.Color = dracula_rgb_colors(1,:);
    
    % Set data label colors
    set(ax,'XColor',dracula_hex_colors{3});
    set(ax,'YColor',dracula_hex_colors{3});
    set(ax,'ZColor',dracula_hex_colors{3});
    
    % Set axis label colors
    ax.Title.Color=dracula_hex_colors{3};
    ax.Subtitle.Color=dracula_hex_colors{4};
    ax.YLabel.Color=dracula_hex_colors{3};
    ax.XLabel.Color=dracula_hex_colors{3};
    ax.ZLabel.Color=dracula_hex_colors{3};
    
    % Set color order of the plot
    ax.ColorOrder=co;
    
    % For box charts
    box_chart_obj = findobj(f,'Type','BoxChart');
    for k = 1:size(box_chart_obj,1)
	    box_chart_obj(k).WhiskerLineColor=dracula_hex_colors{3};
    end
    
    % For contour plots
    contour_obj = findobj(f,'Type','Contour');
    if size(contour_obj,1) > 0
	    colormap(dracula_cmap)
    end
    
    % For contourslice plots
    contourslice_obj = findobj(f,'Type','patch');
    if size(contourslice_obj,1) > 0
	    colormap(dracula_cmap)
    end
    
    % For surf plots
    surf_obj = findobj(f,'Type','surf');
    if size(surf_obj,1) > 0
	    colormap(dracula_cmap)
    end
    
    % For image plots
    image_obj = findobj(f,'Type','Image');
    if size(image_obj,1) > 0
	    colormap(dracula_cmap)
	    image_obj.CDataMapping = 'scaled';
    end
    
    % Apply draculize to legend objects
    legendHandle = findobj(f,'Type','Legend');
    if ~isempty(legendHandle)
	    for k=1:size(legendHandle,1)
            legendHandle(k).Color=dracula_hex_colors{1};
            legendHandle(k).EdgeColor=dracula_hex_colors{3};
            legendHandle(k).TextColor=dracula_hex_colors{3};
	    end
    end
    
    % Apply draculize to colorbar objects
    colorbarHandle = findobj(f,'Type','Colorbar');
    if ~isempty(colorbarHandle)
        colormap(dracula_cmap)
	    for k=1:size(colorbarHandle,1)
            colorbarHandle(k).Color=dracula_hex_colors{3};
            colorbarHandle(k).TickDirection='out';
            colorbarHandle(k).Label.Color=dracula_hex_colors{3};
	    end
    end
    
    % Apply draculize to text objects
    textHandle = findobj(f,'Type','Text');
    if ~isempty(textHandle)
	    for k=1:size(textHandle,1)
            textHandle(k).Color=dracula_hex_colors{3};
	    end
    end
end