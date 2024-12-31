function dracula_colororder(varargin)
%Applies the Dracula color order to the current axes.
%
%OPTIONAL NAME-VALUE PAIRS
%  Style :: Sets the order of the colors {"classic" (default) | "distinct" | "rainbow"}
%      N :: The number of colors {must be between 1 and 7}
%  Order :: Choose to flip the order of the colors {"normal" (default) | "reverse"}
%
%
%Example 1
% x = linspace(0,10)';
% Y = ones(length(x),7).*(x.^0.67)+[6 5 4 3 2 1 0];
% plot(x,Y)
% dracula_colororder
%
%Example 2
% plot(x,Y)
% dracula_colororder(Style='rainbow',Order='reverse')
%
%
%See also
% draculize dracula_colormap

% (C) Austin M. Weber 2024

% Parse the user inputs
p = inputParser;
defaultStyle = 'default';
defaultN = 7;
defaultOrder = 'normal';
addParameter(p, 'style', defaultStyle, @(x) ischar(x) || isstring(x));
addParameter(p, 'N', defaultN, @(x) isscalar(x));
addParameter(p, 'Order', defaultOrder, @(x) ischar(x) || isstring(x));
parse(p, varargin{:});
style = lower(p.Results.style);
N = p.Results.N;
order = lower(p.Results.Order);

% Define the default color order
load("dracula.mat","dracula_rgb_colors")
default_color_order = dracula_rgb_colors(5:end,:);

% Define the classic color order: similar to the MATLAB "gem" color order
blue=dracula_rgb_colors(5,:);
green=dracula_rgb_colors(6,:);
orange=dracula_rgb_colors(7,:);
pink=dracula_rgb_colors(8,:);
purple=dracula_rgb_colors(9,:);
red=dracula_rgb_colors(10,:);
yellow=dracula_rgb_colors(11,:);
distinct_color_order = [blue;orange;purple;green;pink;yellow;red];
rainbow_color_order = [red;orange;yellow;green;blue;purple;pink];

% Set the style
switch style
    case 'default'
        co = default_color_order;
    case 'classic'
        % Same as default
        co = default_color_order;
    case 'distinct'
        co = distinct_color_order;
    case 'rainbow'
        co = rainbow_color_order;
    otherwise
        error('Style not recognized. Try ''classic'', ''distinct'', or ''rainbow''.')
end

% Finalize the color order
switch order
    case 'normal'
        % Do nothing
    case 'reverse'
        co = flipud(co);
    otherwise
        error('Order must be set to either ''normal'' or ''reverse''.')
end

% Finalize the number of colors
co = co(1:N,:);

% Apply color order to axes
ax=gca;
colororder(ax, co)

end